#!/bin/bash
# ============================================================
# Setup del servidor para Workshop Odoo
# Ejecutar como root o con sudo en Rocky Linux / Ubuntu
# ============================================================

set -euo pipefail

ROCKY_LINUX=false
UBUNTU=false
if [ -f /etc/rocky-release ] || grep -qi rocky /etc/os-release 2>/dev/null; then
    ROCKY_LINUX=true
elif grep -qi ubuntu /etc/os-release 2>/dev/null; then
    UBUNTU=true
fi

echo "════════════════════════════════════════════"
echo "  Odoo Workshop — Setup del Servidor"
echo "  OS: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo "════════════════════════════════════════════"

# ── 1. Verificar .env ─────────────────────────────────────
if [ ! -f .env ]; then
    echo "❌ No se encuentra .env"
    echo "   Copiá .env.example a .env y editá las contraseñas:"
    echo "   cp .env.example .env && nano .env"
    exit 1
fi

# Cargar variables del .env (solo las que nos interesan)
set -a; source .env; set +a

# ── 2. Verificar recursos del servidor ───────────────────
echo "[1/7] Verificando recursos del servidor..."
TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
TOTAL_CPU=$(nproc)
echo "   → RAM: ${TOTAL_MEM} MB"
echo "   → CPUs: ${TOTAL_CPU}"

if [ "$TOTAL_CPU" -lt 4 ]; then
    echo "   ⚠️  Menos de 4 vCPU. Reducir workers en odoo.conf."
fi
if [ "$TOTAL_MEM" -lt 7500 ]; then
    echo "   ⚠️  RAM < 8 GB. Reducir workers y conexiones."
fi

# ── 3. Verificar Docker y Docker Compose ─────────────────
echo "[2/7] Verificando Docker..."
if ! command -v docker &> /dev/null; then
    echo "   → Instalando Docker..."
    if $ROCKY_LINUX; then
        dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
        dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    elif $UBUNTU; then
        curl -fsSL https://get.docker.com | bash
    else
        curl -fsSL https://get.docker.com | bash
    fi
    systemctl enable docker
    systemctl start docker
fi

echo "   → Docker: $(docker --version)"
echo "   → Compose: $(docker compose version)"

# ── 4. Generar archivos de configuración desde .env ──────
echo "[3/7] Generando configuración desde .env..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Generar odoo.conf desde la plantilla
sed -e "s/__POSTGRES_DB__/${POSTGRES_DB}/g" \
    -e "s/__POSTGRES_USER__/${POSTGRES_USER}/g" \
    -e "s/__POSTGRES_PASSWORD__/${POSTGRES_PASSWORD}/g" \
    -e "s/__ODOO_MASTER_PASSWORD__/${ODOO_MASTER_PASSWORD}/g" \
    "$PROJECT_DIR/odoo/odoo.conf" > "$PROJECT_DIR/odoo/odoo.conf.tmp"
mv "$PROJECT_DIR/odoo/odoo.conf.tmp" "$PROJECT_DIR/odoo/odoo.conf"
echo "   → odoo/odoo.conf generado ✅"

# ── 5. Ajustar permisos ──────────────────────────────────
echo "[4/7] Ajustando permisos..."
mkdir -p "$PROJECT_DIR/odoo/extra-addons"
chmod 777 "$PROJECT_DIR/odoo/extra-addons"
chmod 755 "$PROJECT_DIR/scripts/"*.sh
echo "   → Permisos OK"

# ── 6. Levantar contenedores ──────────────────────────────
echo "[5/7] Descargando imágenes y levantando servicios..."
cd "$PROJECT_DIR"
docker compose pull
docker compose up -d db
echo "   → Esperando PostgreSQL (15s)..."
sleep 15

docker compose up -d odoo
echo "   → Esperando Odoo (puede tardar 2-3 min la 1ra vez)..."
sleep 30

# Esperar healthcheck de Odoo
for i in $(seq 1 12); do
    if docker compose exec odoo curl -sf http://localhost:8069/web/health > /dev/null 2>&1; then
        echo "   → Odoo saludable ✅"
        break
    fi
    echo "   → Esperando Odoo... (${i}/12)"
    sleep 15
done

docker compose up -d nginx
echo "   → Nginx levantado ✅"

# ── 7. Cargar datos y crear usuarios ──────────────────────
echo "[6/7] Cargando datos demo..."
bash "$PROJECT_DIR/scripts/load_demo_data.sh"

echo "[7/7] Creando usuarios del workshop..."
bash "$PROJECT_DIR/scripts/create_users.sh"

# ── 8. Backup inicial ────────────────────────────────────
echo "→ Realizando backup inicial..."
bash "$PROJECT_DIR/scripts/backup.sh"

# ── Resumen final ────────────────────────────────────────
IP=$(ip route get 1 | awk '{print $7; exit}')
echo ""
echo "════════════════════════════════════════════"
echo "  ✅ WORKSHOP LISTO"
echo "════════════════════════════════════════════"
echo "  URL:        http://${NGINX_HOST:-odoo.workshop.local}"
echo "  IP acceso:  http://${IP}"
echo "  Admin:      admin / ${ADMIN_PWD:-cambiar}"
echo ""
echo "  Usuarios:   g{1..5}_{nombre} / TechFarma2026!"
echo "  pgAdmin:    http://${IP}:5050 (si se levantó con --profile tools)"
echo "════════════════════════════════════════════"
echo ""
echo "  Para monitorear: docker compose logs -f odoo"
echo "  Para ver recursos: watch -n 2 docker stats"
echo "════════════════════════════════════════════"
