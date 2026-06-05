#!/bin/bash
# ============================================================
# update_ip.sh — Actualiza la IP del servidor Odoo
# ============================================================
# Uso: bash scripts/update_ip.sh <nueva-ip>
#
# Ejemplo:
#   bash scripts/update_ip.sh 192.168.1.100
#
# Esto actualiza:
#   - .env        → NGINX_HOST
#   - nginx/      → server_name en odoo.conf
#   - Recarga Nginx para aplicar cambios
# ============================================================

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "❌ Uso: $0 <nueva-ip>"
    echo "   Ejemplo: $0 192.168.1.100"
    exit 1
fi

NEW_IP="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "════════════════════════════════════════════"
echo "  Actualizando IP del servidor"
echo "  Nueva IP: ${NEW_IP}"
echo "════════════════════════════════════════════"

# ── 1. Validar formato IP ──────────────────────────────────
if ! [[ "$NEW_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Formato de IP inválido: ${NEW_IP}"
    exit 1
fi

# ── 2. Actualizar .env ─────────────────────────────────────
if [ -f "$PROJECT_DIR/.env" ]; then
    if grep -q "^NGINX_HOST=" "$PROJECT_DIR/.env"; then
        sed -i "s/^NGINX_HOST=.*/NGINX_HOST=${NEW_IP}/" "$PROJECT_DIR/.env"
    else
        echo "NGINX_HOST=${NEW_IP}" >> "$PROJECT_DIR/.env"
    fi
    echo "  ✅ .env → NGINX_HOST=${NEW_IP}"
else
    echo "  ⚠️  .env no encontrado. Creando..."
    echo "NGINX_HOST=${NEW_IP}" > "$PROJECT_DIR/.env"
fi

# ── 3. Actualizar nginx/odoo.conf ────────────────────────
NGINX_CONF="$PROJECT_DIR/nginx/odoo.conf"
if [ -f "$NGINX_CONF" ]; then
    sed -i "s/server_name .*/server_name ${NEW_IP} _;/" "$NGINX_CONF"
    echo "  ✅ nginx/odoo.conf → server_name ${NEW_IP}"
else
    echo "  ⚠️  ${NGINX_CONF} no encontrado"
fi

# ── 4. Recargar Nginx ──────────────────────────────────────
if docker ps --format '{{.Names}}' | grep -q 'odoo_workshop_nginx'; then
    echo "  🔄 Recargando Nginx..."
    docker exec odoo_workshop_nginx nginx -s reload && echo "  ✅ Nginx recargado" || echo "  ⚠️  No se pudo recargar Nginx"
else
    echo "  ⚠️  Nginx no está corriendo. Hacé 'docker compose up -d nginx' después."
fi

# ── 5. Resumen ─────────────────────────────────────────────
echo ""
echo "════════════════════════════════════════════"
echo "  ✅ IP actualizada a ${NEW_IP}"
echo "════════════════════════════════════════════"
echo ""
echo "  Accedé a Odoo en:"
echo "    http://${NEW_IP}"
echo ""
echo "  Si la presentación tiene la IP hardcodeada,"
echo "  actualizala también en:"
echo "    docs/02_presentacion_marp.md"
echo "════════════════════════════════════════════"
