# 🛠️ Guía Operativa — Taller Odoo TIGE 2026

> Instrucciones rápidas para levantar, operar y actualizar el servidor del workshop.
> Los datos sensibles (contraseñas) están en `.env` (no trackeado en git).

---

## 📡 Conexión al servidor

```bash
# Datos de conexión (ver .env para credenciales)
ssh <usuario>@<ip-del-servidor>
```

> **Recordatorio:** La IP cambia cuando conectás en la facultad. Actualizala con:
> ```bash
> bash scripts/update_ip.sh <nueva-ip>
> ```

---

## 🚀 Puesta en marcha

```bash
# 1. Asegurate de tener el .env configurado
cp .env.example .env
# Editar .env con las contraseñas deseadas

# 2. Setup completo (TODO automático)
sudo bash scripts/setup.sh

# O paso a paso:
docker compose up -d                    # Levantar servicios
bash scripts/load_demo_data.sh          # Cargar datos demo
bash scripts/create_users.sh            # Crear 40 usuarios
```

---

## 📋 Verificar que todo funciona

```bash
# Estado de los servicios
docker compose ps

# Logs en tiempo real
docker compose logs -f odoo

# Recursos
watch -n 2 docker stats

# Probar acceso local
curl -I http://localhost:8069
```

**URL de acceso:** `http://<ip-del-servidor>` (o `http://odoo.workshop.local` si hay DNS)

---

## 🔄 Cuando cambie la IP (al llegar a la facultad)

```bash
# 1. Actualizar IP en todos los archivos que la referencian
bash scripts/update_ip.sh <nueva-ip>

# 2. Reemplazar en la presentación (si hace falta)
#    En la presentación se usa el dominio odoo.workshop.local.
#    Si no hay DNS, los alumnos acceden por IP.
```

**Qué hace `update_ip.sh`:**
1. Actualiza `NGINX_HOST` en `.env`
2. Actualiza `server_name` en `nginx/odoo.conf`
3. Recarga Nginx
4. Muestra la nueva URL de acceso

---

## 📸 Backup y recuperación

```bash
# Backup manual
bash scripts/backup.sh

# Los backups quedan en backups/*.dump
# Para restaurar:
# pg_restore -d odoo_workshop -U odoo_workshop_user backups/<archivo>.dump
```

---

## 👥 Usuarios del workshop

| Grupo | Departamento | Cant. | Login ejemplo | Password |
|-------|-------------|-------|---------------|----------|
| G1 | Ventas & CRM | 8 | `g1_ana` | `TechFarma2026!` |
| G2 | Supply Chain | 8 | `g2_maria` | `TechFarma2026!` |
| G3 | Manufactura | 8 | `g3_juan` | `TechFarma2026!` |
| G4 | Contabilidad | 8 | `g4_sofia` | `TechFarma2026!` |
| G5 | RRHH & TI | 8 | `g5_carlos` | `TechFarma2026!` |

**Admin Odoo:** `admin` / (ver `ADMIN_PWD` en `.env`)

---

## 🔥 Firewall — Abrir puertos (Rocky Linux)

```bash
# Puerto 80 para Odoo (HTTP)
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=80/tcp

# Puerto 443 si usás HTTPS
sudo firewall-cmd --add-port=443/tcp --permanent
sudo firewall-cmd --add-port=443/tcp

# Verificar reglas
sudo firewall-cmd --list-all
```

---

## 🛠️ Si hay que reinicializar la base de datos

Si Odoo no arranca porque la BD quedó corrupta:

```bash
docker compose stop odoo
docker compose exec -T db psql -U odoo_workshop_user -d postgres -c "DROP DATABASE IF EXISTS odoo_workshop;"
docker compose run --rm odoo odoo -d odoo_workshop -i base --stop-after-init \
  --db_host=db --db_user=odoo_workshop_user --db_password=<password> \
  --db_port=5432 --addons-path=/usr/lib/python3/dist-packages/odoo/addons \
  --http-port=8070
docker compose up -d odoo
```

---

## 📦 Servicios

| Servicio | Puerto interno | Acceso |
|----------|---------------|--------|
| Odoo | 8069 | `http://<ip>` (vía Nginx) |
| Nginx | 80 / 443 | Público |
| pgAdmin | 5050 | `http://<ip>:5050` (perfil `tools`) |

---

## 🧹 Al finalizar

```bash
# Backup final
bash scripts/backup.sh

# Bajar servicios
docker compose down

# Opcional: backup completo de la base de datos
docker compose exec db pg_dump -U odoo_workshop_user odoo_workshop > backup_final.sql
```
