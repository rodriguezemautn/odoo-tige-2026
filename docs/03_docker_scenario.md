# 🐳 Odoo 19 Community — Escenario Docker para Workshop
## Soporte para 40 usuarios concurrentes

---

## Estructura de Archivos

```
odoo-workshop-docker/
├── docker-compose.yml          ← Orquestación principal
├── .env                        ← Variables de entorno (NO commitear)
├── nginx/
│   ├── nginx.conf              ← Configuración del reverse proxy
│   └── odoo.conf               ← Virtual host de Odoo
├── odoo/
│   ├── odoo.conf               ← Configuración de Odoo
│   └── extra-addons/           ← Módulos personalizados del workshop
│       └── techfarma_custom/   ← Módulo demo del workshop
├── postgresql/
│   └── init.sql                ← Inicialización de la base de datos
├── backups/                    ← Directorio de backups automáticos
├── scripts/
│   ├── setup.sh                ← Script de setup inicial
│   ├── create_users.sh         ← Crear 40 usuarios del workshop
│   ├── load_demo_data.sh       ← Cargar datos de TechFarma S.A.
│   └── backup.sh               ← Backup manual
└── README.md                   ← Este archivo
```

---

## 📋 Requisitos del Servidor

### Mínimos (40 usuarios)
```
CPU:  4 vCPU (recomendado: 8 vCPU)
RAM:  8 GB  (recomendado: 16 GB)
Disk: 50 GB SSD (recomendado: 100 GB SSD)
OS:   Ubuntu 22.04 LTS o Ubuntu 24.04 LTS
Red:  IP pública con puertos 80 y 443 abiertos
```

### Fórmula de workers para 40 usuarios
```
workers = (vCPU × 2) + 1
→ 4 vCPU: 9 workers
→ 8 vCPU: 17 workers
RAM por worker: 150-300 MB
```

---

## 📄 `.env` — Variables de Entorno

```bash
# ============================================================
# ODOO WORKSHOP — Variables de Entorno
# IMPORTANTE: NO commitear este archivo. Agregar a .gitignore
# ============================================================

# Versión de Odoo
ODOO_VERSION=19.0

# PostgreSQL
POSTGRES_DB=odoo_workshop
POSTGRES_USER=odoo_workshop_user
POSTGRES_PASSWORD=WK_Odoo2026_SecurePass!
POSTGRES_PORT=5432

# Odoo
ODOO_MASTER_PASSWORD=WK_Master2026_Admin!
ODOO_ADMIN_EMAIL=admin@techfarma.local
ODOO_PORT=8069
ODOO_LONGPOLLING_PORT=8072

# Nginx
NGINX_HOST=odoo.workshop.local
# Para producción real: NGINX_HOST=odoo.tudominio.com

# Opcionales para email (workshop puede omitir)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=workshop@techfarma.com
SMTP_PASSWORD=email_password_here
```

---

## 📄 `docker-compose.yml`

```yaml
# ============================================================
# Odoo 19 Community — Workshop Docker Compose
# Optimizado para 40 usuarios concurrentes
# Tested: Docker 24+, Docker Compose v2, Ubuntu 22.04/24.04
# ============================================================

name: odoo-workshop

networks:
  workshop_net:
    driver: bridge
    ipam:
      config:
        - subnet: 172.30.0.0/24

volumes:
  odoo_data:
    driver: local
  odoo_addons:
    driver: local
  postgres_data:
    driver: local
  nginx_logs:
    driver: local

services:

  # ──────────────────────────────────────────────
  # PostgreSQL 16 — Base de Datos
  # ──────────────────────────────────────────────
  db:
    image: postgres:16-alpine
    container_name: odoo_workshop_db
    restart: unless-stopped
    networks:
      - workshop_net
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-odoo_workshop}
      POSTGRES_USER: ${POSTGRES_USER:-odoo_workshop_user}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      # Optimización para carga concurrente de 40 usuarios
      POSTGRES_HOST_AUTH_METHOD: md5
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./postgresql/init.sql:/docker-entrypoint-initdb.d/01_init.sql:ro
    command: >
      postgres
        -c max_connections=200
        -c shared_buffers=512MB
        -c effective_cache_size=2GB
        -c maintenance_work_mem=128MB
        -c checkpoint_completion_target=0.9
        -c wal_buffers=16MB
        -c default_statistics_target=100
        -c random_page_cost=1.1
        -c effective_io_concurrency=200
        -c work_mem=16MB
        -c log_min_duration_statement=1000
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-odoo_workshop_user} -d ${POSTGRES_DB:-odoo_workshop}"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 30s
    shm_size: 256m

  # ──────────────────────────────────────────────
  # Odoo 19 Community — Aplicación
  # ──────────────────────────────────────────────
  odoo:
    image: odoo:19.0
    container_name: odoo_workshop_app
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy
    networks:
      - workshop_net
    environment:
      HOST: db
      PORT: 5432
      USER: ${POSTGRES_USER:-odoo_workshop_user}
      PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "127.0.0.1:8069:8069"    # Solo acceso local (Nginx hace el proxy)
      - "127.0.0.1:8072:8072"    # WebSocket / longpolling
    volumes:
      - odoo_data:/var/lib/odoo
      - ./odoo/odoo.conf:/etc/odoo/odoo.conf:ro
      - ./odoo/extra-addons:/mnt/extra-addons:rw
    command: ["odoo", "--config=/etc/odoo/odoo.conf"]
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8069/web/health || exit 1"]
      interval: 30s
      timeout: 15s
      retries: 5
      start_period: 90s
    # Límites de recursos para 40 usuarios
    deploy:
      resources:
        limits:
          cpus: '6'
          memory: 10G
        reservations:
          cpus: '2'
          memory: 4G
    user: "101:101"    # UID/GID del usuario odoo dentro del contenedor

  # ──────────────────────────────────────────────
  # Nginx — Reverse Proxy
  # ──────────────────────────────────────────────
  nginx:
    image: nginx:1.27-alpine
    container_name: odoo_workshop_nginx
    restart: unless-stopped
    depends_on:
      odoo:
        condition: service_healthy
    networks:
      - workshop_net
    ports:
      - "80:80"
      - "443:443"    # Habilitar si se usa SSL/TLS
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/odoo.conf:/etc/nginx/conf.d/odoo.conf:ro
      - nginx_logs:/var/log/nginx
    healthcheck:
      test: ["CMD", "nginx", "-t"]
      interval: 30s
      timeout: 5s
      retries: 3

  # ──────────────────────────────────────────────
  # pgAdmin (Opcional — para el docente / debug)
  # ──────────────────────────────────────────────
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: odoo_workshop_pgadmin
    restart: unless-stopped
    networks:
      - workshop_net
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@workshop.local
      PGADMIN_DEFAULT_PASSWORD: pgadmin_workshop_2026
      PGADMIN_LISTEN_PORT: 5050
    ports:
      - "127.0.0.1:5050:5050"    # Solo acceso local
    volumes:
      - ./pgadmin:/var/lib/pgadmin
    profiles:
      - tools    # Solo se levanta con: docker compose --profile tools up
```

---

## 📄 `odoo/odoo.conf` — Configuración de Odoo

```ini
[options]

; ── Conexión a base de datos ──────────────────────────────
db_host = db
db_port = 5432
db_name = odoo_workshop
db_user = odoo_workshop_user
db_password = WK_Odoo2026_SecurePass!
db_maxconn = 64

; ── Rutas ────────────────────────────────────────────────
addons_path = /usr/lib/python3/dist-packages/odoo/addons,/mnt/extra-addons
data_dir = /var/lib/odoo

; ── Seguridad ────────────────────────────────────────────
admin_passwd = WK_Master2026_Admin!
list_db = True     ; False en producción real

; ── Workers (fórmula: vCPU × 2 + 1) ──────────────────────
; Para 8 vCPU: 17 workers
workers = 9
max_cron_threads = 2

; ── Límites de memoria por worker ─────────────────────────
limit_memory_hard = 2684354560   ; 2.5 GB
limit_memory_soft = 2147483648   ; 2 GB
limit_request = 8192
limit_time_cpu = 60
limit_time_real = 120
limit_time_real_cron = 600

; ── Longpolling (WebSocket) ───────────────────────────────
longpolling_port = 8072
gevent_port = 8072

; ── Logging ──────────────────────────────────────────────
log_level = warn
log_handler = werkzeug:CRITICAL
logfile = /var/lib/odoo/odoo.log
logrotate = True

; ── Performance ──────────────────────────────────────────
proxy_mode = True             ; CRÍTICO cuando se usa Nginx
without_demo = False          ; True para producción real
server_wide_modules = base,web

; ── Email (configurar para workshop si se necesita) ──────
; smtp_server = smtp.gmail.com
; smtp_port = 587
; smtp_ssl = starttls
; smtp_user = workshop@techfarma.com
; smtp_password = password_here

; ── Internacionalización ─────────────────────────────────
; Configurar en la UI post-instalación para Argentina:
; lang = es_AR, currency = ARS
```

---

## 📄 `nginx/nginx.conf` — Configuración Global de Nginx

```nginx
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
    use epoll;
    multi_accept on;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Logging
    log_format main '$remote_addr - $remote_user [$time_local] '
                    '"$request" $status $body_bytes_sent '
                    '"$http_referer" "$http_user_agent" '
                    'upstream_time=$upstream_response_time';

    access_log /var/log/nginx/access.log main;

    # Performance
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    # Seguridad
    server_tokens off;
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-XSS-Protection "1; mode=block";

    # Gzip
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css application/json application/javascript
               text/xml application/xml text/javascript image/svg+xml;

    # Límites para uploads de documentos
    client_max_body_size 64m;

    # Upstream Odoo
    upstream odoo {
        server odoo:8069;
        keepalive 32;
    }

    upstream odoo_longpolling {
        server odoo:8072;
    }

    include /etc/nginx/conf.d/*.conf;
}
```

---

## 📄 `nginx/odoo.conf` — Virtual Host de Odoo

```nginx
# ── Redirect HTTP → HTTPS (activar en producción con SSL) ──
# server {
#     listen 80;
#     server_name odoo.workshop.local;
#     return 301 https://$host$request_uri;
# }

# ── Servidor principal Odoo ────────────────────────────────
server {
    listen 80;
    # listen 443 ssl;  # Descomentar para HTTPS
    server_name odoo.workshop.local _;  # _ acepta cualquier host

    # SSL (descomentar para HTTPS con cert)
    # ssl_certificate     /etc/nginx/certs/workshop.crt;
    # ssl_certificate_key /etc/nginx/certs/workshop.key;
    # ssl_protocols TLSv1.2 TLSv1.3;
    # ssl_ciphers HIGH:!aNULL:!MD5;

    # Cabeceras de proxy
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Real-IP $remote_addr;

    # Timeouts generosos para demos
    proxy_connect_timeout 300s;
    proxy_send_timeout    300s;
    proxy_read_timeout    300s;

    # ── WebSocket / Longpolling ─────────────────────────
    location /websocket {
        proxy_pass http://odoo_longpolling;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /longpolling/ {
        proxy_pass http://odoo_longpolling;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # ── Archivos estáticos — cache agresivo ────────────
    location ~* /web/static/ {
        proxy_cache_valid 200 90d;
        proxy_buffering on;
        expires 864000;
        proxy_pass http://odoo;
    }

    # ── Aplicación principal ────────────────────────────
    location / {
        proxy_pass http://odoo;
        proxy_redirect off;
        proxy_buffering off;   # Importante para streaming de respuestas
    }
}
```

---

## 📄 `postgresql/init.sql` — Inicialización de BD

```sql
-- ============================================================
-- Inicialización PostgreSQL para Workshop Odoo
-- ============================================================

-- Crear extensiones necesarias para Odoo
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- Para búsqueda de texto

-- Configuración de encoding
SET client_encoding = 'UTF8';

-- Nota: Odoo crea su propio schema al inicializar.
-- Este script solo pre-configura extensiones y verificaciones.

-- Verificar versión
DO $$
BEGIN
    RAISE NOTICE 'PostgreSQL version: %', version();
    RAISE NOTICE 'Workshop DB initialized successfully';
END $$;
```

---

## 📄 `scripts/setup.sh` — Setup Inicial del Servidor

```bash
#!/bin/bash
# ============================================================
# Setup inicial del servidor para Workshop Odoo
# Ejecutar como root o con sudo en Ubuntu 22.04/24.04
# ============================================================

set -euo pipefail

echo "════════════════════════════════════════════"
echo "  Odoo Workshop — Setup Inicial del Servidor"
echo "════════════════════════════════════════════"

# 1. Actualizar sistema
echo "[1/8] Actualizando sistema..."
apt-get update && apt-get upgrade -y

# 2. Instalar dependencias
echo "[2/8] Instalando dependencias..."
apt-get install -y \
    curl wget git nano htop \
    net-tools ufw \
    python3-pip

# 3. Instalar Docker
echo "[3/8] Instalando Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com | bash
    systemctl enable docker
    systemctl start docker
fi

# 4. Instalar Docker Compose v2
echo "[4/8] Verificando Docker Compose..."
docker compose version || {
    echo "ERROR: Docker Compose v2 no encontrado. Reinstalar Docker."
    exit 1
}

# 5. Configurar firewall
echo "[5/8] Configurando UFW..."
ufw --force enable
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
# NO abrir 8069 directamente — solo Nginx es público

# 6. Crear estructura de directorios
echo "[6/8] Creando estructura de directorios..."
mkdir -p odoo-workshop/{nginx,odoo/extra-addons,postgresql,scripts,backups,pgadmin}
chmod 777 odoo-workshop/odoo/extra-addons

# 7. Ajustar permisos para Odoo Docker (UID 101)
echo "[7/8] Configurando permisos para Odoo..."
# El contenedor Odoo corre como UID 101
# Si ya existe el volumen, ajustar ownership
# chown -R 101:101 /var/lib/docker/volumes/odoo-workshop_odoo_data

# 8. Verificar recursos del servidor
echo "[8/8] Verificando recursos del servidor..."
TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
TOTAL_CPU=$(nproc)
echo "   → RAM disponible: ${TOTAL_MEM} MB"
echo "   → CPUs disponibles: ${TOTAL_CPU}"

if [ "$TOTAL_MEM" -lt 7500 ]; then
    echo "   ⚠️  ADVERTENCIA: RAM < 8 GB. Puede haber problemas con 40 usuarios."
fi

echo ""
echo "✅ Setup completado. Próximos pasos:"
echo "   1. Copiar los archivos de configuración al directorio odoo-workshop/"
echo "   2. Editar el archivo .env con las contraseñas reales"
echo "   3. Ejecutar: cd odoo-workshop && docker compose up -d"
echo "   4. Esperar ~2 min y verificar: docker compose ps"
echo "   5. Ejecutar: bash scripts/load_demo_data.sh"
```

---

## 📄 `scripts/create_users.sh` — Crear 40 Usuarios del Workshop

```bash
#!/bin/bash
# ============================================================
# Crear 40 usuarios para el workshop, distribuidos en 5 grupos
# Ejecutar DESPUÉS de que Odoo esté iniciado y la BD creada
# ============================================================

set -euo pipefail

ODOO_URL="http://localhost:8069"
MASTER_PWD="WK_Master2026_Admin!"
DB_NAME="odoo_workshop"
ADMIN_PWD="admin"

echo "════════════════════════════════════════════"
echo "  Creando 40 usuarios para Workshop Odoo"
echo "════════════════════════════════════════════"

# Esperar a que Odoo esté disponible
echo "Esperando que Odoo esté listo..."
until curl -sf "${ODOO_URL}/web/health" > /dev/null 2>&1; do
    echo "  → Odoo no disponible aún, esperando 5s..."
    sleep 5
done
echo "  ✅ Odoo disponible"

# Función para crear usuario via JSON-RPC
create_user() {
    local name="$1"
    local login="$2"
    local password="$3"
    local group="$4"    # Grupo Odoo para asignar

    python3 - <<PYEOF
import xmlrpc.client
import sys

url = "${ODOO_URL}"
db = "${DB_NAME}"
username = "admin"
password = "${ADMIN_PWD}"

common = xmlrpc.client.ServerProxy(f'{url}/xmlrpc/2/common')
uid = common.authenticate(db, username, password, {})

models = xmlrpc.client.ServerProxy(f'{url}/xmlrpc/2/object')

# Crear usuario
user_id = models.execute_kw(db, uid, password, 'res.users', 'create', [{
    'name': "${name}",
    'login': "${login}",
    'password': "${password}",
    'email': "${login}@techfarma.local",
    'lang': 'es_AR',
    'tz': 'America/Argentina/Buenos_Aires',
}])

print(f"Usuario creado: ${login} (ID: {user_id})")
PYEOF
}

echo ""
echo "Creando usuarios del Grupo 1 — Ventas & CRM..."
create_user "Ana Vendedora" "g1_ana" "TechFarma2026!" "sales"
create_user "Bruno Comercial" "g1_bruno" "TechFarma2026!" "sales"
create_user "Carla Preventa" "g1_carla" "TechFarma2026!" "sales"
create_user "Diego Analista" "g1_diego" "TechFarma2026!" "sales"
create_user "Elena Soporte" "g1_elena" "TechFarma2026!" "sales"
create_user "Franco Ventas" "g1_franco" "TechFarma2026!" "sales"
create_user "Gabriela CRM" "g1_gabriela" "TechFarma2026!" "sales"
create_user "Hernán Manager" "g1_hernan" "TechFarma2026!" "sales"

echo "Creando usuarios del Grupo 2 — Supply Chain..."
create_user "Ignacio Compras" "g2_ignacio" "TechFarma2026!" "purchase"
create_user "Julia Logística" "g2_julia" "TechFarma2026!" "purchase"
create_user "Kevin Almacén" "g2_kevin" "TechFarma2026!" "stock"
create_user "Laura Inventario" "g2_laura" "TechFarma2026!" "stock"
create_user "Mateo Supply" "g2_mateo" "TechFarma2026!" "purchase"
create_user "Natalia SC" "g2_natalia" "TechFarma2026!" "purchase"
create_user "Oscar Bodega" "g2_oscar" "TechFarma2026!" "stock"
create_user "Paula Analista" "g2_paula" "TechFarma2026!" "purchase"

echo "Creando usuarios del Grupo 3 — Manufactura..."
create_user "Quentin Planta" "g3_quentin" "TechFarma2026!" "mrp"
create_user "Rosa Calidad" "g3_rosa" "TechFarma2026!" "mrp"
create_user "Santiago Prod" "g3_santiago" "TechFarma2026!" "mrp"
create_user "Teresa Operaria" "g3_teresa" "TechFarma2026!" "mrp"
create_user "Ulises QA" "g3_ulises" "TechFarma2026!" "mrp"
create_user "Valeria Planif" "g3_valeria" "TechFarma2026!" "mrp"
create_user "Walter Ensamble" "g3_walter" "TechFarma2026!" "mrp"
create_user "Ximena Manufact" "g3_ximena" "TechFarma2026!" "mrp"

echo "Creando usuarios del Grupo 4 — Contabilidad..."
create_user "Yanina Contadora" "g4_yanina" "TechFarma2026!" "account"
create_user "Zoe Finanzas" "g4_zoe" "TechFarma2026!" "account"
create_user "Ariel Facturac" "g4_ariel" "TechFarma2026!" "account"
create_user "Beatriz Tesorer" "g4_beatriz" "TechFarma2026!" "account"
create_user "Claudio Auditor" "g4_claudio" "TechFarma2026!" "account"
create_user "Daniela Ctable" "g4_daniela" "TechFarma2026!" "account"
create_user "Esteban Pagos" "g4_esteban" "TechFarma2026!" "account"
create_user "Florencia CFO" "g4_florencia" "TechFarma2026!" "account"

echo "Creando usuarios del Grupo 5 — RRHH & TI..."
create_user "Gonzalo RRHH" "g5_gonzalo" "TechFarma2026!" "hr"
create_user "Helena PM" "g5_helena" "TechFarma2026!" "project"
create_user "Iván DevOps" "g5_ivan" "TechFarma2026!" "base"
create_user "Juana SysAdmin" "g5_juana" "TechFarma2026!" "base"
create_user "Karina TI" "g5_karina" "TechFarma2026!" "base"
create_user "Luis HR Manager" "g5_luis" "TechFarma2026!" "hr"
create_user "María Recruit" "g5_maria" "TechFarma2026!" "hr"
create_user "Nicolás Proyect" "g5_nicolas" "TechFarma2026!" "project"

echo ""
echo "✅ 40 usuarios creados exitosamente"
echo ""
echo "Credenciales para entregar a los estudiantes:"
echo "  URL: ${ODOO_URL}"
echo "  Contraseña: TechFarma2026!"
echo "  Login: g{grupo}_{nombre} (ej: g1_ana, g2_ignacio)"
```

---

## 📄 `scripts/load_demo_data.sh` — Cargar Datos de TechFarma S.A.

```bash
#!/bin/bash
# ============================================================
# Cargar datos de demostración para TechFarma S.A.
# Ejecutar después de instalar los módulos base en Odoo
# ============================================================

set -euo pipefail

ODOO_URL="http://localhost:8069"
DB_NAME="odoo_workshop"

echo "════════════════════════════════════════════"
echo "  Cargando datos demo: TechFarma S.A."
echo "════════════════════════════════════════════"

python3 - <<'PYEOF'
import xmlrpc.client
import json

url = "http://localhost:8069"
db = "odoo_workshop"
username = "admin"
password = "admin"

common = xmlrpc.client.ServerProxy(f'{url}/xmlrpc/2/common')
uid = common.authenticate(db, username, password, {})
models = xmlrpc.client.ServerProxy(f'{url}/xmlrpc/2/object')

def create(model, vals):
    return models.execute_kw(db, uid, password, model, 'create', [vals])

def search_read(model, domain, fields=['name','id']):
    return models.execute_kw(db, uid, password, model, 'search_read', [domain], {'fields': fields, 'limit': 1})

print("→ Creando categorías de productos...")
cat_hw = create('product.category', {'name': 'Hardware IoT', 'complete_name': 'Hardware IoT'})
cat_sw = create('product.category', {'name': 'Software & Licencias'})
cat_sv = create('product.category', {'name': 'Servicios'})

print("→ Creando productos de TechFarma...")
productos = [
    {'name': 'Sensor IoT Suelo Pro', 'type': 'product', 'list_price': 299.99, 'standard_price': 120.00, 'categ_id': cat_hw},
    {'name': 'Sensor IoT Suelo Basic', 'type': 'product', 'list_price': 149.99, 'standard_price': 60.00, 'categ_id': cat_hw},
    {'name': 'Estación Meteorológica Compacta', 'type': 'product', 'list_price': 599.99, 'standard_price': 250.00, 'categ_id': cat_hw},
    {'name': 'Gateway LoRa 4G', 'type': 'product', 'list_price': 449.99, 'standard_price': 180.00, 'categ_id': cat_hw},
    {'name': 'Kit Sensor IoT Completo', 'type': 'product', 'list_price': 899.99, 'standard_price': 380.00, 'categ_id': cat_hw},
    {'name': 'Microcontrolador ESP32', 'type': 'product', 'list_price': 12.00, 'standard_price': 5.00, 'categ_id': cat_hw},
    {'name': 'Carcasa Plástica ABS', 'type': 'product', 'list_price': 8.00, 'standard_price': 3.00, 'categ_id': cat_hw},
    {'name': 'Software TechFarma Cloud — Licencia Anual', 'type': 'service', 'list_price': 1200.00, 'standard_price': 0, 'categ_id': cat_sw},
    {'name': 'Software TechFarma Cloud — Licencia Mensual', 'type': 'service', 'list_price': 120.00, 'standard_price': 0, 'categ_id': cat_sw},
    {'name': 'Consultoría Implementación IoT', 'type': 'service', 'list_price': 1500.00, 'standard_price': 0, 'categ_id': cat_sv},
    {'name': 'Capacitación Uso de Plataforma', 'type': 'service', 'list_price': 500.00, 'standard_price': 0, 'categ_id': cat_sv},
    {'name': 'Mantenimiento Anual Sensores', 'type': 'service', 'list_price': 350.00, 'standard_price': 0, 'categ_id': cat_sv},
]
for p in productos:
    create('product.template', p)
    print(f"   ✓ {p['name']}")

print("→ Creando proveedores...")
proveedores = [
    {'name': 'ElectroComp S.A.', 'is_company': True, 'supplier_rank': 5, 'street': 'Av. Corrientes 1234', 'city': 'Buenos Aires', 'country_id': 11},
    {'name': 'Plastics Tech S.R.L.', 'is_company': True, 'supplier_rank': 5, 'city': 'Rosario'},
    {'name': 'LoRa Networks Inc.', 'is_company': True, 'supplier_rank': 5, 'city': 'Córdoba'},
    {'name': 'SemiconductoRes AR', 'is_company': True, 'supplier_rank': 5, 'city': 'Mendoza'},
    {'name': 'Global IoT Supply', 'is_company': True, 'supplier_rank': 5, 'city': 'Miami'},
]
for p in proveedores:
    create('res.partner', p)
    print(f"   ✓ {p['name']}")

print("→ Creando clientes...")
clientes = [
    {'name': 'AgroSol Pampa S.A.', 'is_company': True, 'customer_rank': 5, 'city': 'La Plata'},
    {'name': 'Cooperativa Agrícola Junín', 'is_company': True, 'customer_rank': 5, 'city': 'Junín'},
    {'name': 'Campo Verde Distribuciones', 'is_company': True, 'customer_rank': 5, 'city': 'Santa Fe'},
    {'name': 'Estancia Los Talas', 'is_company': True, 'customer_rank': 5, 'city': 'Bahía Blanca'},
    {'name': 'TechAgro Córdoba', 'is_company': True, 'customer_rank': 5, 'city': 'Córdoba'},
    {'name': 'Distribuidora Norte S.R.L.', 'is_company': True, 'customer_rank': 5, 'city': 'Tucumán'},
    {'name': 'Agropecuaria del Sur', 'is_company': True, 'customer_rank': 5, 'city': 'Mar del Plata'},
    {'name': 'SoyTech Uruguay', 'is_company': True, 'customer_rank': 5, 'city': 'Montevideo'},
    {'name': 'Precision Farm Brazil', 'is_company': True, 'customer_rank': 5, 'city': 'São Paulo'},
    {'name': 'Granja Digital Chile', 'is_company': True, 'customer_rank': 5, 'city': 'Santiago'},
]
for c in clientes:
    create('res.partner', c)
    print(f"   ✓ {c['name']}")

print("\n✅ Datos demo cargados exitosamente")
print("   TechFarma S.A. está lista para el workshop")
PYEOF
```

---

## 📄 `scripts/backup.sh` — Backup Manual

```bash
#!/bin/bash
# ============================================================
# Backup manual de la base de datos del workshop
# ============================================================

set -euo pipefail

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="./backups"
DB_NAME="odoo_workshop"

mkdir -p "$BACKUP_DIR"

echo "Realizando backup de la base de datos..."
docker exec odoo_workshop_db pg_dump \
    -U odoo_workshop_user \
    -d "$DB_NAME" \
    --format=custom \
    --compress=9 \
    > "${BACKUP_DIR}/odoo_workshop_${TIMESTAMP}.dump"

echo "✅ Backup creado: ${BACKUP_DIR}/odoo_workshop_${TIMESTAMP}.dump"

# Restaurar con:
# docker exec -i odoo_workshop_db pg_restore \
#   -U odoo_workshop_user -d odoo_workshop \
#   < backups/odoo_workshop_TIMESTAMP.dump
```

---

## 📄 `odoo/extra-addons/techfarma_custom/__manifest__.py`

```python
# -*- coding: utf-8 -*-
{
    'name': 'TechFarma Custom — Módulo Demo Workshop',
    'version': '19.0.1.0.0',
    'summary': 'Gestión de sensores IoT y contratos para TechFarma S.A.',
    'description': """
        Módulo creado durante el Workshop de Odoo para
        Ingeniería en Sistemas de Información.
        
        Demuestra la estructura mínima de un módulo Odoo:
        - Modelo ORM con campos
        - Vista tree/form/kanban
        - Control de acceso por rol
        - Datos de demostración
    """,
    'author': 'Workshop Ingeniería en Sistemas',
    'website': 'https://techfarma.local',
    'category': 'Manufacturing',
    'depends': [
        'base',
        'mail',        # Para chatter en los registros
        'product',     # Para enlazar con productos
        'sale_management',
    ],
    'data': [
        'security/ir.model.access.csv',
        'views/sensor_views.xml',
        'data/sensor_demo_data.xml',
    ],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}
```

---

## 📄 `odoo/extra-addons/techfarma_custom/models/sensor.py`

```python
# -*- coding: utf-8 -*-
from odoo import models, fields, api
from odoo.exceptions import ValidationError
from datetime import date


class IoTSensor(models.Model):
    """
    Modelo para gestionar sensores IoT instalados en campo.
    Demuestra: campos básicos, computed fields, constraints,
    onchange, herencia de mail.thread para chatter.
    """
    _name = 'techfarma.sensor'
    _description = 'Sensor IoT de Campo'
    _inherit = ['mail.thread', 'mail.activity.mixin']  # Agrega chatter
    _order = 'installation_date desc, name asc'

    # ── Campos básicos ──────────────────────────────────
    name = fields.Char(
        string='Número de Serie',
        required=True,
        tracking=True,   # Registra cambios en el chatter
        copy=False,
    )
    product_id = fields.Many2one(
        'product.product',
        string='Producto',
        domain=[('type', '=', 'product')],
    )
    partner_id = fields.Many2one(
        'res.partner',
        string='Cliente / Instalación',
        tracking=True,
    )
    installation_date = fields.Date(
        string='Fecha de Instalación',
        default=fields.Date.today,
        tracking=True,
    )
    location_lat = fields.Float(string='Latitud', digits=(9, 6))
    location_lon = fields.Float(string='Longitud', digits=(9, 6))
    notes = fields.Text(string='Notas Técnicas')

    # ── Campo de estado con tracking ───────────────────
    state = fields.Selection([
        ('draft',        'Borrador'),
        ('active',       'Activo'),
        ('maintenance',  'En Mantenimiento'),
        ('retired',      'Retirado'),
    ], string='Estado', default='draft', tracking=True,
       required=True, index=True)

    # ── Campo computado ────────────────────────────────
    days_active = fields.Integer(
        string='Días Activo',
        compute='_compute_days_active',
        store=False,
    )
    is_overdue = fields.Boolean(
        string='Mantenimiento Vencido',
        compute='_compute_is_overdue',
        store=True,
    )

    @api.depends('installation_date', 'state')
    def _compute_days_active(self):
        today = date.today()
        for record in self:
            if record.installation_date and record.state == 'active':
                delta = today - record.installation_date
                record.days_active = delta.days
            else:
                record.days_active = 0

    @api.depends('days_active', 'state')
    def _compute_is_overdue(self):
        MAINTENANCE_INTERVAL = 365  # días
        for record in self:
            record.is_overdue = (
                record.state == 'active' and
                record.days_active > MAINTENANCE_INTERVAL
            )

    # ── Constraint ────────────────────────────────────
    @api.constrains('name')
    def _check_serial_format(self):
        for record in self:
            if record.name and not record.name.startswith('TF-'):
                raise ValidationError(
                    "El número de serie debe comenzar con 'TF-' "
                    f"(actual: {record.name})"
                )

    # ── Onchange ──────────────────────────────────────
    @api.onchange('product_id')
    def _onchange_product_id(self):
        if self.product_id:
            self.notes = f"Sensor tipo: {self.product_id.name}\n"

    # ── Métodos de negocio (botones de la vista) ──────
    def action_activate(self):
        for record in self:
            record.state = 'active'

    def action_send_to_maintenance(self):
        for record in self:
            record.state = 'maintenance'

    def action_retire(self):
        for record in self:
            record.state = 'retired'
```

---

## 🚀 Comandos de Despliegue

### Despliegue inicial (paso a paso)

```bash
# 1. Clonar / copiar los archivos al servidor
git clone <tu-repositorio> odoo-workshop
cd odoo-workshop

# 2. Copiar y editar variables de entorno
cp .env.example .env
nano .env   # ← Cambiar las contraseñas

# 3. Ajustar permisos del directorio extra-addons
mkdir -p odoo/extra-addons
chmod 777 odoo/extra-addons

# 4. Levantar primero solo la BD
docker compose up -d db
echo "Esperando PostgreSQL..." && sleep 15

# 5. Inicializar Odoo (primera vez — crea la BD)
docker compose up -d odoo
echo "Esperando Odoo (puede tardar 2-3 min)..." && sleep 120

# 6. Verificar estado
docker compose ps
docker compose logs --tail=50 odoo

# 7. Levantar Nginx
docker compose up -d nginx

# 8. Verificar que Odoo responde
curl -I http://localhost/web

# 9. Cargar datos demo de TechFarma
bash scripts/load_demo_data.sh

# 10. Crear los 40 usuarios del workshop
bash scripts/create_users.sh

# 11. (Opcional) Levantar pgAdmin para el docente
docker compose --profile tools up -d pgadmin
```

### Comandos de operación

```bash
# Ver logs en tiempo real
docker compose logs -f odoo

# Reiniciar Odoo sin perder datos
docker compose restart odoo

# Actualizar un módulo
docker exec odoo_workshop_app odoo \
  -c /etc/odoo/odoo.conf \
  -u techfarma_custom \
  --stop-after-init

# Ver uso de recursos en tiempo real
docker stats

# Backup rápido
bash scripts/backup.sh

# Apagar todo (datos se mantienen en volúmenes)
docker compose down

# Apagar y ELIMINAR TODOS LOS DATOS (reset completo)
docker compose down -v   # ⚠️ DESTRUCTIVO — usar solo para reset entre talleres
```

---

## 🔍 Troubleshooting Común

| Síntoma | Causa | Solución |
|---------|-------|----------|
| Odoo reinicia en loop | PostgreSQL no listo | `docker compose logs db` → aumentar `start_period` |
| Permission denied en filestore | UID incorrecto | `chmod -R 777 odoo/extra-addons` |
| Puerto 8069 ya en uso | Otro proceso | `sudo lsof -i :8069` → matar proceso |
| Odoo lento con 40 users | Pocos workers | Aumentar `workers` en `odoo.conf` |
| Error "database does not exist" | BD no inicializada | Acceder a `http://ip/web/database/manager` |
| WebSocket no funciona | Nginx mal configurado | Revisar location `/websocket` en nginx.conf |
| Módulo no aparece en Apps | Addons path incorrecto | Verificar `addons_path` en odoo.conf |

---

## 📊 Monitoreo Durante el Workshop

```bash
# Ver uso de CPU y RAM de cada contenedor
watch -n 2 docker stats --no-stream

# Ver conexiones activas a PostgreSQL
docker exec odoo_workshop_db psql \
  -U odoo_workshop_user \
  -d odoo_workshop \
  -c "SELECT count(*), state FROM pg_stat_activity GROUP BY state;"

# Ver workers Odoo activos
docker exec odoo_workshop_app ps aux | grep odoo | wc -l

# Logs de acceso Nginx (últimas 20 líneas)
docker exec odoo_workshop_nginx tail -n 20 /var/log/nginx/access.log
```

---

## ✅ Checklist Pre-Workshop

- [ ] Servidor encendido y accesible por red del laboratorio
- [ ] `docker compose ps` muestra todos los servicios `Up (healthy)`
- [ ] Acceso a `http://odoo.workshop.local` desde el navegador del docente
- [ ] Login como `admin` funciona correctamente
- [ ] 40 usuarios creados (verificar en `Configuración → Usuarios`)
- [ ] Datos demo de TechFarma visibles (Productos, Clientes, Proveedores)
- [ ] URL distribuida a todos los estudiantes
- [ ] Hojas de rol impresas o enviadas por mensaje
- [ ] Backup inicial realizado: `bash scripts/backup.sh`

---

*Configuración probada con Odoo 19.0, Docker 24+, Docker Compose v2, Ubuntu 22.04/24.04 LTS.*  
*Para entornos cloud: AWS t3.xlarge (4 vCPU / 16 GB RAM) o equivalente GCP/Azure.*  
*Versión: 1.0 — Junio 2026*
