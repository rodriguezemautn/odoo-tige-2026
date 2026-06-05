#!/bin/bash
# ============================================================
# Backup de la base de datos del workshop Odoo
# Formato: custom (comprimido, listo para pg_restore)
# ============================================================

set -euo pipefail

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$(cd "$(dirname "$0")/.." && pwd)/backups"
DB_NAME="odoo_workshop"
DB_USER="odoo_workshop_user"

mkdir -p "$BACKUP_DIR"

echo "════════════════════════════════════════════"
echo "  Backup de Base de Datos Odoo"
echo "  Base: ${DB_NAME}"
echo "════════════════════════════════════════════"

BACKUP_FILE="${BACKUP_DIR}/odoo_workshop_${TIMESTAMP}.dump"

docker exec odoo_workshop_db pg_dump \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    --format=custom \
    --compress=9 \
    --verbose \
    > "$BACKUP_FILE" 2>&1 | tail -5

echo ""
echo "✅ Backup creado: ${BACKUP_FILE}"

# Mostrar tamaño
SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "   Tamaño: ${SIZE}"

echo ""
echo "Para restaurar:"
echo "  docker exec -i odoo_workshop_db pg_restore \\"
echo "    -U ${DB_USER} -d ${DB_NAME} \\"
echo "    --clean --if-exists \\"
echo "    < ${BACKUP_FILE}"
echo ""
echo "📋 Backups disponibles:"
ls -lh "${BACKUP_DIR}/" 2>/dev/null || echo "   (ninguno)"
