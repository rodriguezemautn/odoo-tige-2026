#!/bin/bash
# ============================================================
# Cargar datos de demostración para TechFarma S.A.
# Productos, proveedores y clientes vía XML-RPC
# ============================================================

set -euo pipefail

ODOO_URL="http://localhost:8069"
DB_NAME="odoo_workshop"

echo "════════════════════════════════════════════"
echo "  Cargando datos demo: TechFarma S.A."
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

def create(model, vals):
    return models.execute_kw(DB_NAME, uid, ADMIN_PWD, model, 'create', [vals])

def search(model, domain):
    return models.execute_kw(DB_NAME, uid, ADMIN_PWD, model, 'search', [domain])

def search_read(model, domain, fields=None):
    kwargs = {}
    if fields:
        kwargs['fields'] = fields
    return models.execute_kw(DB_NAME, uid, ADMIN_PWD, model, 'search_read', [domain], kwargs)

# Obtener ID del país Argentina
argentina = search_read('res.country', [['code', '=', 'AR']], fields=['id'])
if argentina:
    country_ar = argentina[0]['id']
    print(f"🌎 Argentina ID: {country_ar}")
else:
    country_ar = None
    print("⚠️  Argentina no encontrada, usando None")

# Obtener impuesto IVA 21% (Argentina) o crear uno por defecto
tax_ids = search_read('account.tax', [['type_tax_use', '=', 'sale'], ['amount', '=', 21.0]], fields=['id'])
iva21_id = tax_ids[0]['id'] if tax_ids else False
if iva21_id:
    print(f"💰 IVA 21% ID: {iva21_id}")
else:
    print("⚠️  IVA 21% no encontrado, se usará sin impuesto")

# Obtener unidad de medida por defecto (Unidades)
uom_unit = search_read('uom.uom', [['name', '=', 'Units']], fields=['id'])
uom_id = uom_unit[0]['id'] if uom_unit else 1

# ── Crear categorías de productos ───────────────────────
print("\n📦 Creando categorías de productos...")
cat_hw = create('product.category', {
    'name': 'Hardware IoT',
})
cat_sw = create('product.category', {
    'name': 'Software & Licencias',
})
cat_sv = create('product.category', {
    'name': 'Servicios',
})
print(f"   ✅ Hardware IoT ID: {cat_hw}")
print(f"   ✅ Software & Licencias ID: {cat_sw}")
print(f"   ✅ Servicios ID: {cat_sv}")

# ── Crear productos ─────────────────────────────────────
print("\n🔧 Creando productos de TechFarma...")
productos = [
    # Hardware
    {'name': 'Sensor IoT Suelo Pro', 'type': 'product', 'list_price': 299.99, 'standard_price': 120.00, 'categ_id': cat_hw},
    {'name': 'Sensor IoT Suelo Basic', 'type': 'product', 'list_price': 149.99, 'standard_price': 60.00, 'categ_id': cat_hw},
    {'name': 'Estación Meteorológica Compacta', 'type': 'product', 'list_price': 599.99, 'standard_price': 250.00, 'categ_id': cat_hw},
    {'name': 'Gateway LoRa 4G', 'type': 'product', 'list_price': 449.99, 'standard_price': 180.00, 'categ_id': cat_hw},
    {'name': 'Kit Sensor IoT Completo', 'type': 'product', 'list_price': 899.99, 'standard_price': 380.00, 'categ_id': cat_hw},
    {'name': 'Microcontrolador ESP32', 'type': 'product', 'list_price': 12.00, 'standard_price': 5.00, 'categ_id': cat_hw},
    {'name': 'Carcasa Plástica ABS', 'type': 'product', 'list_price': 8.00, 'standard_price': 3.00, 'categ_id': cat_hw},
    # Software
    {'name': 'TechFarma Cloud — Licencia Anual', 'type': 'service', 'list_price': 1200.00, 'standard_price': 0, 'categ_id': cat_sw},
    {'name': 'TechFarma Cloud — Licencia Mensual', 'type': 'service', 'list_price': 120.00, 'standard_price': 0, 'categ_id': cat_sw},
    # Servicios
    {'name': 'Consultoría Implementación IoT', 'type': 'service', 'list_price': 1500.00, 'standard_price': 0, 'categ_id': cat_sv},
    {'name': 'Capacitación Uso de Plataforma', 'type': 'service', 'list_price': 500.00, 'standard_price': 0, 'categ_id': cat_sv},
    {'name': 'Mantenimiento Anual Sensores', 'type': 'service', 'list_price': 350.00, 'standard_price': 0, 'categ_id': cat_sv},
]
for p in productos:
    create('product.template', p)
    print(f"   ✅ {p['name']}")
    time.sleep(0.1)

# ── Crear proveedores ───────────────────────────────────
print("\n🏭 Creando proveedores...")
proveedores = [
    {'name': 'ElectroComp S.A.', 'is_company': True, 'supplier_rank': 5, 'street': 'Av. Corrientes 1234', 'city': 'Buenos Aires', 'country_id': country_ar},
    {'name': 'Plastics Tech S.R.L.', 'is_company': True, 'supplier_rank': 5, 'city': 'Rosario', 'country_id': country_ar},
    {'name': 'LoRa Networks Inc.', 'is_company': True, 'supplier_rank': 5, 'city': 'Córdoba', 'country_id': country_ar},
    {'name': 'SemiconductoRes AR', 'is_company': True, 'supplier_rank': 5, 'city': 'Mendoza', 'country_id': country_ar},
    {'name': 'Global IoT Supply', 'is_company': True, 'supplier_rank': 5, 'city': 'Miami'},
]
for p in proveedores:
    create('res.partner', p)
    print(f"   ✅ {p['name']}")
    time.sleep(0.1)

# ── Crear clientes ──────────────────────────────────────
print("\n👥 Creando clientes...")
clientes = [
    {'name': 'AgroSol Pampa S.A.', 'is_company': True, 'customer_rank': 5, 'city': 'La Plata', 'country_id': country_ar},
    {'name': 'Cooperativa Agrícola Junín', 'is_company': True, 'customer_rank': 5, 'city': 'Junín', 'country_id': country_ar},
    {'name': 'Campo Verde Distribuciones', 'is_company': True, 'customer_rank': 5, 'city': 'Santa Fe', 'country_id': country_ar},
    {'name': 'Estancia Los Talas', 'is_company': True, 'customer_rank': 5, 'city': 'Bahía Blanca', 'country_id': country_ar},
    {'name': 'TechAgro Córdoba', 'is_company': True, 'customer_rank': 5, 'city': 'Córdoba', 'country_id': country_ar},
    {'name': 'Distribuidora Norte S.R.L.', 'is_company': True, 'customer_rank': 5, 'city': 'Tucumán', 'country_id': country_ar},
    {'name': 'Agropecuaria del Sur', 'is_company': True, 'customer_rank': 5, 'city': 'Mar del Plata', 'country_id': country_ar},
    {'name': 'SoyTech Uruguay', 'is_company': True, 'customer_rank': 5, 'city': 'Montevideo'},
    {'name': 'Precision Farm Brazil', 'is_company': True, 'customer_rank': 5, 'city': 'São Paulo'},
    {'name': 'Granja Digital Chile', 'is_company': True, 'customer_rank': 5, 'city': 'Santiago'},
]
for c in clientes:
    create('res.partner', c)
    print(f"   ✅ {c['name']}")
    time.sleep(0.1)

print("\n════════════════════════════════════════════")
print("  ✅ Datos demo cargados exitosamente")
print("  TechFarma S.A. está lista para el workshop")
print("════════════════════════════════════════════")

PYEOF
