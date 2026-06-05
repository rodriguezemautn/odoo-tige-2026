#!/bin/bash
# ============================================================
# Crear usuarios del workshop desde lista de alumnos TIGE 2026
# Generado automáticamente desde docs/TIGE 2026_lista de alumnos.xlsx
# ============================================================

set -euo pipefail

ODOO_URL="http://localhost:8069"
DB_NAME="odoo_workshop"
ADMIN_USER="admin"
ADMIN_PWD="admin"

echo "════════════════════════════════════════════"
echo "  Creando usuarios para Workshop Odoo"
echo "  Total: 42 estudiantes en 5 grupos"
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

python3 << 'PYEOF'
import xmlrpc.client
import sys
import time
import re

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
    parts = xml_id.split('.')
    if len(parts) != 2:
        return None
    module, name = parts
    result = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'ir.model.data', 'search_read',
        [[['module', '=', module], ['name', '=', name]]],
        {'fields': ['res_id'], 'limit': 1})
    if result:
        return result[0]['res_id']
    fallback = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.groups', 'search_read',
        [[['name', 'ilike', name.replace('group_', '').replace('_', ' ')]]],
        {'fields': ['id'], 'limit': 1})
    if fallback:
        return fallback[0]['id']
    print(f"  \u26a0\ufe0f Grupo no encontrado: {xml_id}")
    return None

GROUP_CACHE = {}

def get_group(xml_id):
    if xml_id not in GROUP_CACHE:
        GROUP_CACHE[xml_id] = get_group_id(xml_id)
    return GROUP_CACHE[xml_id]

def generar_login(grupo, nombre_completo, usados):
    partes = nombre_completo.split(',', 1)
    apellido = partes[0].strip()
    nombre = partes[1].strip() if len(partes) > 1 else ""
    primer_nombre = nombre.split()[0] if nombre else ""
    base = f"g{grupo}_{primer_nombre.lower()}"
    base = re.sub(r'[^a-z0-9_]', '', base)
    if base not in usados:
        usados.add(base)
        return base
    base2 = f"{base}_{apellido[0].lower()}"
    base2 = re.sub(r'[^a-z0-9_]', '', base2)
    if base2 not in usados:
        usados.add(base2)
        return base2
    base3 = f"g{grupo}_{primer_nombre.lower()}_{apellido.lower()}"
    base3 = re.sub(r'[^a-z0-9_]', '', base3)[:60]
    usados.add(base3)
    return base3

def crear_usuario(name, login, password, email, group_xml_ids):
    existing = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.users', 'search',
        [[['login', '=', login]]])
    if existing:
        print(f"  \u23ed\ufe0f Ya existe: {login} ({name})")
        return existing[0]
    group_ids = []
    for xml_id in group_xml_ids:
        gid = get_group(xml_id)
        if gid:
            group_ids.append(gid)
    if not group_ids:
        base_group = get_group('base.group_user')
        if base_group:
            group_ids = [base_group]
    try:
        user_id = models.execute_kw(DB_NAME, uid, ADMIN_PWD, 'res.users', 'create', [{
            'name': name,
            'login': login,
            'password': password,
            'email': email,
            'lang': 'en_US',
            'tz': 'America/Argentina/Buenos_Aires',
            'notification_type': 'email',
            'group_ids': [(4, gid) for gid in group_ids],
        }])
        print(f"  \u2705 {login} \u2192 {name}")
        time.sleep(0.2)
        return user_id
    except Exception as e:
        print(f"  \u274c Error creando {login}: {e}")
        return None

PASSWORD = "TechFarma2026!"

# Datos de estudiantes

print("\n──────────────────────────────────────────────")
print("Grupo 1 — Ventas & CRM")
print("──────────────────────────────────────────────")
GROUP1_GROUPS = ["sales_team.group_sale_salesman", "base.group_user"]
crear_usuario("BACCARINI, CAMILA", "g1_camila", PASSWORD, "cambaccarini01@gmail.com", GROUP1_GROUPS)
crear_usuario("BATTISTELLA, TOMAS", "g1_tomas", PASSWORD, "tbattistella@alu.frlp.utn.edu.ar", GROUP1_GROUPS)
crear_usuario("BELLINGERI, DANIELA SOL", "g1_daniela", PASSWORD, "andromeda0209@gmail.com", GROUP1_GROUPS)
crear_usuario("BORDA, ALESANDRO PATRICIO", "g1_alesandro", PASSWORD, "patricio.borda@outlook.com", GROUP1_GROUPS)
crear_usuario("BRESCIANI, ISABELLA", "g1_isabella", PASSWORD, "brescianisa@gmail.com", GROUP1_GROUPS)
crear_usuario("BUIATTI, PEDRO NAZARENO", "g1_pedro", PASSWORD, "buiattip58@gmail.com", GROUP1_GROUPS)
crear_usuario("CAPRA, VALENTINA", "g1_valentina", PASSWORD, "valentinacapra@alu.frlp.utn.edu.ar", GROUP1_GROUPS)
crear_usuario("CAPRE, RODRIGO JOAQUIN", "g1_rodrigo", PASSWORD, "rjcapre@alu.frlp.utn.edu.ar", GROUP1_GROUPS)

print("\n──────────────────────────────────────────────")
print("Grupo 2 — Supply Chain")
print("──────────────────────────────────────────────")
GROUP2_GROUPS = ["purchase.group_purchase_user", "stock.group_stock_user", "base.group_user"]
crear_usuario("CAPUTO, JOAQUIN", "g2_joaquin", PASSWORD, "joaquincaputo84@gmail.com", GROUP2_GROUPS)
crear_usuario("CARDOSO, CAROLINA MICAELA", "g2_carolina", PASSWORD, "carolinamicaelacardoso@alu.frlp.utn.edu.ar", GROUP2_GROUPS)
crear_usuario("CASTRO GONZALES, BRAIAN GERMAN", "g2_braian", PASSWORD, "bcastrogonzales@alu.frlp.utn.edu.ar", GROUP2_GROUPS)
crear_usuario("CHECA, AUGUSTO", "g2_augusto", PASSWORD, "augustocheca@alu.frlp.utn.edu.ar", GROUP2_GROUPS)
crear_usuario("COCH, TOMAS AXEL", "g2_tomas", PASSWORD, "tomascoch@hotmail.com", GROUP2_GROUPS)
crear_usuario("D\u00cdAZ, VALENTINA", "g2_valentina", PASSWORD, "valendiaz01@yahoo.com", GROUP2_GROUPS)
crear_usuario("ELIZALDE, BENJAMIN", "g2_benjamin", PASSWORD, "belizalde@alu.frlp.utn.edu.ar", GROUP2_GROUPS)
crear_usuario("ESPAMER, MARTIN", "g2_martin", PASSWORD, "martinespamer@alu.frlp.utn.edu.ar", GROUP2_GROUPS)

print("\n──────────────────────────────────────────────")
print("Grupo 3 — Manufactura")
print("──────────────────────────────────────────────")
GROUP3_GROUPS = ["mrp.group_mrp_user", "stock.group_stock_user", "base.group_user"]
crear_usuario("FERRARI, AGUSTIN NICOLAS", "g3_agustin", PASSWORD, "aferrari@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("FERRARIS DAVIES, GASTON", "g3_gaston", PASSWORD, "gferrarisdavies@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("FRANCINI, STEFANIA", "g3_stefania", PASSWORD, "stefaniafrancini@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("GARCIA MONTES, LUCIANO TOMAS", "g3_luciano", PASSWORD, "lugarciamontes@gmail.com", GROUP3_GROUPS)
crear_usuario("GENTIL, MORA", "g3_mora", PASSWORD, "moragentil@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("GOSZKO, SOFIA LARA", "g3_sofia", PASSWORD, "slgoszko@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("GUTIERREZ MORA, AGUSTIN", "g3_agustin_g", PASSWORD, "agustingutierrezmora@alu.frlp.utn.edu.ar", GROUP3_GROUPS)
crear_usuario("HIRIART, IRINEO", "g3_irineo", PASSWORD, "irineohiriart@alu.frlp.utn.edu.ar", GROUP3_GROUPS)

print("\n──────────────────────────────────────────────")
print("Grupo 4 — Contabilidad")
print("──────────────────────────────────────────────")
GROUP4_GROUPS = ["account.group_account_user", "base.group_user"]
crear_usuario("KALPIN, SOFIA ROXANA", "g4_sofia", PASSWORD, "sofikalpin@hotmail.com", GROUP4_GROUPS)
crear_usuario("LAURE, VALENTINO", "g4_valentino", PASSWORD, "vlaure@alu.frlp.utn.edu.ar", GROUP4_GROUPS)
crear_usuario("LEIVA, EMANUEL NICOLAS", "g4_emanuel", PASSWORD, "eleiva@alu.frlp.utn.edu.ar", GROUP4_GROUPS)
crear_usuario("LOPEZ, CARINA BEATRIZ", "g4_carina", PASSWORD, "carinablopez@gmail.com", GROUP4_GROUPS)
crear_usuario("LUBERTO, JOAQUIN", "g4_joaquin", PASSWORD, "joaquinluberto@alu.frlp.utn.edu.ar", GROUP4_GROUPS)
crear_usuario("MOLTENI, BALTAZAR", "g4_baltazar", PASSWORD, "baltazarmolteni@alu.frlp.utn.edu.ar", GROUP4_GROUPS)
crear_usuario("MOSCUZZA, VICENTE", "g4_vicente", PASSWORD, "vmoscuzza@alu.frlp.utn.edu.ar", GROUP4_GROUPS)
crear_usuario("PEREZ, GONZALO MARTIN", "g4_gonzalo", PASSWORD, "gnzaaspla@hotmail.com", GROUP4_GROUPS)
crear_usuario("PETOSA AYALA, FRANCO", "g4_franco", PASSWORD, "franco.petosa15@gmail.com", GROUP4_GROUPS)

print("\n──────────────────────────────────────────────")
print("Grupo 5 — RRHH & TI")
print("──────────────────────────────────────────────")
GROUP5_GROUPS = ["hr.group_hr_user", "project.group_project_user", "base.group_user"]
crear_usuario("RAGGI, SOFIA BELEN", "g5_sofia", PASSWORD, "sraggi@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("RAU BEKERMAN, MATIAS NAHUEL", "g5_matias", PASSWORD, "mraubekerman@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("REBOL, MANUEL", "g5_manuel", PASSWORD, "manuelrebol@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("SCIANCA, MANUEL", "g5_manuel_s", PASSWORD, "mscianca@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("SERRA, FACUNDO", "g5_facundo", PASSWORD, "facuterremoto04@gmail.com", GROUP5_GROUPS)
crear_usuario("VALDES, NICOLAS EZEQUIEL", "g5_nicolas", PASSWORD, "nicolasezequielvaldes@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("VIJANDI, IVAN ANDRES", "g5_ivan", PASSWORD, "ivanandresvijandi@alu.frlp.utn.edu.ar", GROUP5_GROUPS)
crear_usuario("GANCIA, LUCIANA", "g5_luciana", PASSWORD, "lugancia@gmail.com", GROUP5_GROUPS)
crear_usuario("MONZON VALERIANO, JAQUELINE DEL PILAR", "g5_jaqueline", PASSWORD, "jaquemonzon31@gmail.com", GROUP5_GROUPS)

print("\n" + "=" * 50)
print("  ✅ 42 usuarios creados/verificados")
print("=" * 50)
print()
print("  Credenciales para los estudiantes:")
print("  " + "-" * 41)
print("  URL:        http://<IP_DEL_SERVIDOR>")
print("  Contraseña: TechFarma2026!")
print()
print("  Grupo 1 — Ventas & CRM:")
print("    g1_camila                 → CAMILA BACCARINI")
print("    g1_tomas                  → TOMAS BATTISTELLA")
print("    g1_daniela                → DANIELA BELLINGERI")
print("    g1_alesandro              → ALESANDRO BORDA")
print("    g1_isabella               → ISABELLA BRESCIANI")
print("    g1_pedro                  → PEDRO BUIATTI")
print("    g1_valentina              → VALENTINA CAPRA")
print("    g1_rodrigo                → RODRIGO CAPRE")
print()
print("  Grupo 2 — Supply Chain:")
print("    g2_joaquin                → JOAQUIN CAPUTO")
print("    g2_carolina               → CAROLINA CARDOSO")
print("    g2_braian                 → BRAIAN CASTRO GONZALES")
print("    g2_augusto                → AUGUSTO CHECA")
print("    g2_tomas                  → TOMAS COCH")
print("    g2_valentina              → VALENTINA DÍAZ")
print("    g2_benjamin               → BENJAMIN ELIZALDE")
print("    g2_martin                 → MARTIN ESPAMER")
print()
print("  Grupo 3 — Manufactura:")
print("    g3_agustin                → AGUSTIN FERRARI")
print("    g3_gaston                 → GASTON FERRARIS DAVIES")
print("    g3_stefania               → STEFANIA FRANCINI")
print("    g3_luciano                → LUCIANO GARCIA MONTES")
print("    g3_mora                   → MORA GENTIL")
print("    g3_sofia                  → SOFIA GOSZKO")
print("    g3_agustin_g              → AGUSTIN GUTIERREZ MORA")
print("    g3_irineo                 → IRINEO HIRIART")
print()
print("  Grupo 4 — Contabilidad:")
print("    g4_sofia                  → SOFIA KALPIN")
print("    g4_valentino              → VALENTINO LAURE")
print("    g4_emanuel                → EMANUEL LEIVA")
print("    g4_carina                 → CARINA LOPEZ")
print("    g4_joaquin                → JOAQUIN LUBERTO")
print("    g4_baltazar               → BALTAZAR MOLTENI")
print("    g4_vicente                → VICENTE MOSCUZZA")
print("    g4_gonzalo                → GONZALO PEREZ")
print("    g4_franco                 → FRANCO PETOSA AYALA")
print()
print("  Grupo 5 — RRHH & TI:")
print("    g5_sofia                  → SOFIA RAGGI")
print("    g5_matias                 → MATIAS RAU BEKERMAN")
print("    g5_manuel                 → MANUEL REBOL")
print("    g5_manuel_s               → MANUEL SCIANCA")
print("    g5_facundo                → FACUNDO SERRA")
print("    g5_nicolas                → NICOLAS VALDES")
print("    g5_ivan                   → IVAN VIJANDI")
print("    g5_luciana                → LUCIANA GANCIA")
print("    g5_jaqueline              → JAQUELINE MONZON VALERIANO")
print()

print()
print("  Grupos cargados en cache:")
for xml_id, gid in GROUP_CACHE.items():
    if gid:
        print(f"    -> {xml_id} = ID: {gid}")
    else:
        print(f"    -> {xml_id} = NO ENCONTRADO")
print()

PYEOF
