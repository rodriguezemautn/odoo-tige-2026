#!/bin/bash
# ============================================================
# Crear 40 usuarios para el workshop, distribuidos en 5 grupos
# con grupos de Odoo asignados correctamente vía XML-RPC
#
# CORRECCIÓN: los grupos se buscan por XML ID (ir.model.data)
# y se asignan con la sintaxis correcta de Odoo (comando (4, id))
# ============================================================

set -euo pipefail

ODOO_URL="http://localhost:8069"
DB_NAME="odoo_workshop"
ADMIN_USER="admin"
ADMIN_PWD="admin"

echo "════════════════════════════════════════════"
echo "  Creando 40 usuarios para Workshop Odoo"
echo "════════════════════════════════════════════"

# Esperar a que Odoo esté disponible
echo "Esperando que Odoo esté listo..."
for i in $(seq 1 24); do
    if curl -sf "${ODOO_URL}/web/health" > /dev/null 2>&1; then
        echo "  ✅ Odoo disponible"
        break
    fi
    echo "  → Esperando... (${i}/24)"
    sleep 5
done

# ── Crear usuarios vía XML-RPC ──────────────────────────
python3 << 'PYEOF'
import xmlrpc.client
import sys
import time

ODOO_URL = "http://localhost:8069"
DB_NAME = "odoo_workshop"
ADMIN_USER = "admin"
ADMIN_PWD = "admin"

# Conectar
common = xmlrpc.client.ServerProxy(f'{ODOO_URL}/xmlrpc/2/common')
uid = common.authenticate(DB_NAME, ADMIN_USER, ADMIN_PWD, {})
if not uid:
    print("❌ No se pudo autenticar como admin")
    sys.exit(1)
print(f"✅ Conectado como admin (UID: {uid})")

models = xmlrpc.client.ServerProxy(f'{ODOO_URL}/xmlrpc/2/object')

def get_group_id(xml_id):
    """Busca un grupo de Odoo por su XML ID completo (ej: 'sales_team.group_sale_salesman')"""
    parts = xml_id.split('.')
    if len(parts) != 2:
        print(f"  ⚠️ XML ID inválido: {xml_id}")
        return None
    module, name = parts
    result = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'ir.model.data', 'search_read',
        [[['module', '=', module], ['name', '=', name]]],
        {'fields': ['res_id'], 'limit': 1})
    if result:
        return result[0]['res_id']
    # Fallback: buscar por name en res.groups
    fallback = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.groups', 'search_read',
        [[['name', 'ilike', name.replace('group_', '').replace('_', ' ')]]],
        {'fields': ['id'], 'limit': 1})
    if fallback:
        return fallback[0]['id']
    print(f"  ⚠️ Grupo no encontrado: {xml_id}")
    return None

# IDs de grupos Odoo (XML IDs de Odoo 19 Community)
# Buscar una vez y cachear
GROUP_CACHE = {}

def get_group(xml_id):
    if xml_id not in GROUP_CACHE:
        GROUP_CACHE[xml_id] = get_group_id(xml_id)
    return GROUP_CACHE[xml_id]

# ── Función para crear usuario ──────────────────────────
def crear_usuario(name, login, password, group_xml_ids):
    """Crea un usuario en Odoo y le asigna grupos."""
    
    # Verificar si ya existe
    existing = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.users', 'search',
        [[['login', '=', login]]])
    if existing:
        print(f"  ⏭️  Usuario ya existe: {login} (ID: {existing[0]})")
        return existing[0]
    
    # Obtener IDs de grupos
    group_ids = []
    for xml_id in group_xml_ids:
        gid = get_group(xml_id)
        if gid:
            group_ids.append(gid)
    
    if not group_ids:
        # Asignar al menos el grupo base (Employee / Internal User)
        base_group = get_group('base.group_user')
        if base_group:
            group_ids = [base_group]
    
    # Crear usuario
    try:
        user_id = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.users', 'create', [{
            'name': name,
            'login': login,
            'password': password,
            'email': f'{login}@techfarma.local',
            'lang': 'es_AR',
            'tz': 'America/Argentina/Buenos_Aires',
            'notification_type': 'email',
            'groups_id': [(4, gid) for gid in group_ids],
        }])
        print(f"  ✅ {login} → {name} (ID: {user_id})")
        time.sleep(0.2)  # Pausa para no saturar XML-RPC
        return user_id
    except Exception as e:
        print(f"  ❌ Error creando {login}: {e}")
        return None

# ── Datos de usuarios ────────────────────────────────────
# Cada grupo tiene su módulo principal + módulo base
print("\n──────────────────────────────────────")
print("Grupo 1 — Ventas & CRM")
print("──────────────────────────────────────")
g1_groups = ['sales_team.group_sale_salesman', 'base.group_user']

crear_usuario("Ana Vendedora", "g1_ana", "TechFarma2026!", g1_groups)
crear_usuario("Bruno Comercial", "g1_bruno", "TechFarma2026!", g1_groups)
crear_usuario("Carla Preventa", "g1_carla", "TechFarma2026!", g1_groups)
crear_usuario("Diego Analista", "g1_diego", "TechFarma2026!", g1_groups)
crear_usuario("Elena Soporte", "g1_elena", "TechFarma2026!", g1_groups)
crear_usuario("Franco Ventas", "g1_franco", "TechFarma2026!", g1_groups)
crear_usuario("Gabriela CRM", "g1_gabriela", "TechFarma2026!", g1_groups)
crear_usuario("Hernán Manager", "g1_hernan", "TechFarma2026!", g1_groups)

print("\n──────────────────────────────────────")
print("Grupo 2 — Supply Chain")
print("──────────────────────────────────────")
g2_groups = ['purchase.group_purchase_user', 'stock.group_stock_user', 'base.group_user']

crear_usuario("Ignacio Compras", "g2_ignacio", "TechFarma2026!", g2_groups)
crear_usuario("Julia Logística", "g2_julia", "TechFarma2026!", g2_groups)
crear_usuario("Kevin Almacén", "g2_kevin", "TechFarma2026!", g2_groups)
crear_usuario("Laura Inventario", "g2_laura", "TechFarma2026!", g2_groups)
crear_usuario("Mateo Supply", "g2_mateo", "TechFarma2026!", g2_groups)
crear_usuario("Natalia SC", "g2_natalia", "TechFarma2026!", g2_groups)
crear_usuario("Oscar Bodega", "g2_oscar", "TechFarma2026!", g2_groups)
crear_usuario("Paula Analista", "g2_paula", "TechFarma2026!", g2_groups)

print("\n──────────────────────────────────────")
print("Grupo 3 — Manufactura")
print("──────────────────────────────────────")
g3_groups = ['mrp.group_mrp_user', 'stock.group_stock_user', 'base.group_user']

crear_usuario("Quentin Planta", "g3_quentin", "TechFarma2026!", g3_groups)
crear_usuario("Rosa Calidad", "g3_rosa", "TechFarma2026!", g3_groups)
crear_usuario("Santiago Prod", "g3_santiago", "TechFarma2026!", g3_groups)
crear_usuario("Teresa Operaria", "g3_teresa", "TechFarma2026!", g3_groups)
crear_usuario("Ulises QA", "g3_ulises", "TechFarma2026!", g3_groups)
crear_usuario("Valeria Planif", "g3_valeria", "TechFarma2026!", g3_groups)
crear_usuario("Walter Ensamble", "g3_walter", "TechFarma2026!", g3_groups)
crear_usuario("Ximena Manufact", "g3_ximena", "TechFarma2026!", g3_groups)

print("\n──────────────────────────────────────")
print("Grupo 4 — Contabilidad")
print("──────────────────────────────────────")
g4_groups = ['account.group_account_user', 'base.group_user']

crear_usuario("Yanina Contadora", "g4_yanina", "TechFarma2026!", g4_groups)
crear_usuario("Zoe Finanzas", "g4_zoe", "TechFarma2026!", g4_groups)
crear_usuario("Ariel Facturac", "g4_ariel", "TechFarma2026!", g4_groups)
crear_usuario("Beatriz Tesorer", "g4_beatriz", "TechFarma2026!", g4_groups)
crear_usuario("Claudio Auditor", "g4_claudio", "TechFarma2026!", g4_groups)
crear_usuario("Daniela Ctable", "g4_daniela", "TechFarma2026!", g4_groups)
crear_usuario("Esteban Pagos", "g4_esteban", "TechFarma2026!", g4_groups)
crear_usuario("Florencia CFO", "g4_florencia", "TechFarma2026!", g4_groups)

print("\n──────────────────────────────────────")
print("Grupo 5 — RRHH & TI")
print("──────────────────────────────────────")
# RRHH usa hr.group_hr_user, Proyecto usa project.group_project_user
g5_hr_groups = ['hr.group_hr_user', 'base.group_user']
g5_project_groups = ['project.group_project_user', 'base.group_user']
g5_it_groups = ['base.group_user']  # IT solo tiene usuario base + acceso técnico

crear_usuario("Gonzalo RRHH", "g5_gonzalo", "TechFarma2026!", g5_hr_groups)
crear_usuario("Helena PM", "g5_helena", "TechFarma2026!", g5_project_groups)
crear_usuario("Iván DevOps", "g5_ivan", "TechFarma2026!", g5_it_groups)
crear_usuario("Juana SysAdmin", "g5_juana", "TechFarma2026!", g5_it_groups)
crear_usuario("Karina TI", "g5_karina", "TechFarma2026!", g5_it_groups)
crear_usuario("Luis HR Manager", "g5_luis", "TechFarma2026!", g5_hr_groups)
crear_usuario("María Recruit", "g5_maria", "TechFarma2026!", g5_hr_groups)
crear_usuario("Nicolás Proyect", "g5_nicolas", "TechFarma2026!", g5_project_groups)

print("\n════════════════════════════════════════════")
print("  ✅ 40 usuarios creados/verificados")
print("════════════════════════════════════════════")
print("")
print("  Credenciales para los estudiantes:")
print("  ─────────────────────────────────────")
print("  URL:        http://<IP_DEL_SERVIDOR>")
print("  Contraseña: TechFarma2026!")
print("  Login:      g{grupo}_{nombre}")
print("")
print("  Ejemplos:")
print("    g1_ana     → Grupo 1 - Ventas")
print("    g2_kevin   → Grupo 2 - Supply Chain")
print("    g3_santiago → Grupo 3 - Manufactura")
print("    g4_yanina  → Grupo 4 - Contabilidad")
print("    g5_gonzalo → Grupo 5 - RRHH & TI")
print("════════════════════════════════════════════")

# Mostrar resumen de grupos cargados
print("\n📋 Grupos cargados en caché:")
for xml_id, gid in GROUP_CACHE.items():
    if gid:
        print(f"   ✅ {xml_id} → ID: {gid}")
    else:
        print(f"   ❌ {xml_id} → NO ENCONTRADO")

PYEOF
