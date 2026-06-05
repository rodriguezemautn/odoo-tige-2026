# 🧩 WORKSHOP SPEC: Odoo ERP para Ingeniería en Sistemas de Información

> **Nivel:** Universitario — Último año de Ingeniería en Sistemas de Información
> **Materia:** Tecnologías de la Información para la Gestión Empresarial (TIGE) - UTN FrLP - Prof. MG. Leandro Rocca
> **Orador invitado:** Emanuel Rodriguez
> **Duración:** 60 minutos  
> **Modalidad:** Presencial / Laboratorio (con escenario Docker compartido)  
> **Cupo:** hasta 40 estudiantes  
> **Formato:** Conferencia interactiva + Práctica guiada + Exploración libre  

---

## 1. CONTEXTO Y JUSTIFICACIÓN PEDAGÓGICA

Los sistemas ERP (Enterprise Resource Planning) son el núcleo tecnológico de la gestión empresarial moderna. Según Gartner, el mercado global de ERP cloud superó los USD 47.000 millones en 2024 y proyecta un crecimiento anual del 10% hasta 2028. Odoo, como plataforma open-source líder en el segmento SME y como opción emergente enterprise, representa una oportunidad única para que los estudiantes de Ingeniería en Sistemas experimenten con un ERP real de clase mundial, construido en tecnologías que dominan (Python, JavaScript, PostgreSQL, Docker).

Este workshop combina teoría ERP con experiencia práctica inmersiva: cada estudiante opera como un rol funcional dentro de una empresa simulada, interactuando con módulos reales en un servidor compartido, lo que replica el entorno de trabajo profesional.

---

## 2. OBJETIVOS DE APRENDIZAJE

Al finalizar el workshop, el estudiante será capaz de:

| # | Objetivo | Taxonomía Bloom |
|---|----------|-----------------|
| 1 | Explicar la arquitectura técnica y el modelo de negocio de Odoo | Comprender |
| 2 | Comparar Odoo Community vs Enterprise con otros ERPs del mercado | Analizar |
| 3 | Navegar el entorno Odoo y ejecutar flujos de negocio extremo a extremo | Aplicar |
| 4 | Identificar el stack tecnológico y las herramientas del desarrollador | Comprender |
| 5 | Diseñar la estructura mínima de un módulo Odoo personalizado | Crear |
| 6 | Implementar y operar un entorno Odoo mediante Docker Compose | Aplicar |

---

## 3. AUDIENCIA Y PRERREQUISITOS

**Perfil del estudiante:**
- Último año de Ingeniería en Sistemas de Información o carrera afín
- Conocimientos básicos de Python y bases de datos relacionales
- Familiaridad con contenedores Docker (deseable)
- Conocimiento de arquitectura cliente-servidor

**Sin prerrequisito de:**
- Experiencia previa con ERP
- Conocimiento de Odoo

---

## 4. ESTRUCTURA TEMPORAL (60 MINUTOS)

```
┌─────────────────────────────────────────────────────────────────────┐
│  BLOQUE 0  │  Bienvenida y configuración de entorno  │  5 min   │
├─────────────────────────────────────────────────────────────────────┤
│  BLOQUE 1  │  ERP & Odoo: Teoría express              │  15 min  │
├─────────────────────────────────────────────────────────────────────┤
│  BLOQUE 2  │  Arquitectura y stack técnico             │  10 min  │
├─────────────────────────────────────────────────────────────────────┤
│  BLOQUE 3  │  Actividades prácticas por roles          │  25 min  │
├─────────────────────────────────────────────────────────────────────┤
│  BLOQUE 4  │  Módulo custom: esqueleto en vivo         │  3 min   │
├─────────────────────────────────────────────────────────────────────┤
│  BLOQUE 5  │  Cierre, Q&A y recursos                  │  2 min   │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 5. CONTENIDOS DETALLADOS

---

### BLOQUE 0 — BIENVENIDA Y CONFIGURACIÓN (5 min)

**Docente:**
- Presentar la empresa ficticia: **"TechFarma S.A."** — startup de productos agroindustriales que digitaliza su operación completa usando Odoo 19 Community.
- Asignar roles según lista de alumnos (ver Sección 8).
- Indicar URL del servidor: `http://odoo.workshop.local` (o IP pública del servidor Docker).
- Credenciales iniciales y contraseña del módulo asignado por rol.

---

### BLOQUE 1 — ERP Y ODOO: TEORÍA EXPRESS (15 min)

#### 1.1 ¿Qué es un ERP?

Un **Enterprise Resource Planning (ERP)** es un sistema de software integrado que permite a una organización gestionar y automatizar sus procesos de negocio mediante una base de datos unificada. Los ERP eliminan los silos de información al conectar finanzas, operaciones, ventas, RRHH, manufactura y logística en una única plataforma.

**Características definitivas de un ERP:**
- Base de datos centralizada y única fuente de verdad
- Módulos funcionales integrados (no sistemas aislados)
- Flujos de trabajo transversales entre departamentos
- Trazabilidad completa de operaciones
- Reportes y dashboards en tiempo real

**Historia de los ERP:**

| Década | Hito |
|--------|------|
| 1960s | MRP (Material Requirements Planning) — IBM, manufactureras |
| 1970s | MRP II — incorpora capacidad de planta y finanzas |
| 1990s | Nace el término "ERP" — Gartner, 1990. SAP R/3 domina |
| 2000s | ERP web-based, Oracle adquiere PeopleSoft (2005) |
| 2010s | Cloud ERP, SaaS ERP (Workday, NetSuite) |
| 2020s | AI-native ERP, composable ERP, micro-ERP open source |

---

#### 1.2 Historia de Odoo

| Año | Evento |
|-----|--------|
| 2002 | Fabien Pinckaers funda TinyERP en Bélgica |
| 2005 | Primera versión pública: TinyERP 1.0 (Febrero) |
| 2009 | Rebrand a **OpenERP** — crack de popularidad global |
| 2010 | OpenERP 6.0 — arquitectura modular madura |
| 2014 | Rebrand definitivo a **Odoo** — Odoo 8.0 |
| 2015 | Odoo 9.0: separación Community / Enterprise |
| 2018 | Odoo 12.0 — ORM renovado, rendimiento PostgreSQL |
| 2020 | Odoo 14.0 — nueva UI, Discuss rediseñado |
| 2022 | Odoo 16.0 — arquitectura spreadsheet nativa |
| 2023 | Odoo 17.0 — último lanzamiento sin restricción open-source |
| 2024 | Odoo 18.0 — IA generativa, nuevo modelo de precios, Odoo Experience Brussels |
| 2025 | **Odoo 19.0** — migración completa a OWL, AI-first, ESG modules |
| 2026 | Odoo 20.0 esperado en Odoo Experience Sep 2026 |

**Datos clave (2025):**
- +12 millones de usuarios activos en 180 países
- +44.000 aplicaciones en Odoo App Store
- Más de 3.000 partners certificados globalmente
- HQ: Ramillies, Bélgica. Fabien Pinckaers continúa como CEO

---

#### 1.3 Versiones y Presentaciones de Odoo

**Modelo de distribución:**

```
Odoo 19.0
├── Community Edition (LGPLv3 — gratuita)
│   ├── CRM, Ventas, Compras básico
│   ├── Inventario básico, Manufactura básica
│   ├── Contabilidad básica
│   ├── Sitio web / eCommerce
│   └── Sin soporte oficial, sin hosting gestionado
│
└── Enterprise Edition (Propietaria)
    ├── Todo lo de Community +
    ├── Módulos avanzados (RRHH, Nómina, BI avanzado)
    ├── Odoo.sh (hosting gestionado con CI/CD)
    ├── App móvil nativa iOS/Android
    ├── Soporte oficial con SLA
    └── Precio: desde USD 19.90/usuario/mes (2025)
```

**Modelo de precios Odoo 18/19:**
1. **One App Free** — 1 aplicación, usuarios ilimitados, gratuita
2. **Standard** — Todas las apps, ~USD 24.90/usuario/mes
3. **Custom** — Multi-empresa, multi-idioma, pricing acordado

---

#### 1.4 Benchmark y Posicionamiento en el Mercado ERP

**Comparativa de principales ERPs (2025):**

| Plataforma | Segmento | Modelo | Precio Base | Fortaleza |
|------------|----------|--------|-------------|-----------|
| **SAP S/4HANA** | Enterprise | Cloud/On-premise | USD 1.800+/usr/año | Complejidad, manufactura |
| **Oracle Fusion** | Enterprise | Cloud | USD 1.600+/usr/año | Finanzas, Supply Chain |
| **Microsoft D365** | Mid-Market | Cloud | USD 180/usr/mes | Integración M365, IA Copilot |
| **NetSuite** | Mid-Market | SaaS | USD 999+/mes base | Contabilidad, multimoneda |
| **Odoo Enterprise** | SME→Mid | Cloud/On-premise | USD 24.90/usr/mes | Precio, modularidad, OSS |
| **Odoo Community** | SME | On-premise | Gratuito | Personalización sin costo |
| **ERPNext** | SME | SaaS/OSS | Gratuito (OSS) | Muy abierto |
| **Dolibarr** | Micro-SME | OSS | Gratuito | Simplicidad |

**Posicionamiento Gartner — Cuadrante Mágico ERP:**

> ⚠️ **Nota académica:** Odoo **no aparece** en el Cuadrante Mágico de Gartner para Cloud ERP for Product-Centric Enterprises (el análisis más relevante), que en 2024-2025 está dominado por Oracle, Microsoft Dynamics 365, SAP, Epicor e Infor como **Líderes**. Odoo no cumple los criterios mínimos de revenue y base instalada enterprise que Gartner exige para la inclusión. Sin embargo:

- Odoo **sí aparece** en análisis de Gartner Peer Insights como plataforma de alto puntaje de satisfacción en SME
- En G2, Capterra y GetApp, Odoo recibe calificaciones de 4.1-4.3/5 con decenas de miles de reviews
- Forrester categoriza Odoo como "Strong Performer" en ERP para mercado medio-bajo
- IDC lo clasifica como referente en el segmento open-source ERP 2024

**Ventajas competitivas de Odoo:**
1. **Costo total de propiedad (TCO)** significativamente menor que SAP/Oracle
2. **Velocidad de implementación** — semanas vs meses/años
3. **Modularidad real** — empieza con 1 módulo, crece sin reemplazar el sistema
4. **Comunidad open-source** — +44.000 módulos, contribuciones globales
5. **Stack moderno** — Python + OWL + PostgreSQL = conocido por devs

---

### BLOQUE 2 — ARQUITECTURA Y STACK TÉCNICO (10 min)

#### 2.1 Arquitectura de Odoo

```
┌─────────────────────────────────────────────────────────────────┐
│                    CLIENTE (Browser / App Móvil)                │
│              OWL Framework (JavaScript/TypeScript)              │
│              QWeb Templates · RPC · WebSocket (8072)           │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTP/HTTPS (port 8069)
┌───────────────────────────▼─────────────────────────────────────┐
│                   SERVIDOR DE APLICACIÓN                        │
│              Python 3.10+ · Werkzeug (HTTP Server)             │
│              Odoo ORM · OpenRPC · Módulos (.py + .xml)         │
│              Cron Jobs · Email Engine · PDF Reports (wkhtmltopdf)│
└───────────────────────────┬─────────────────────────────────────┘
                            │
┌───────────────────────────▼─────────────────────────────────────┐
│                   BASE DE DATOS                                 │
│              PostgreSQL 14+ · Esquema por base de datos        │
│              ORM-only access · Sin acceso directo recomendado  │
└─────────────────────────────────────────────────────────────────┘
```

**Capa de presentación (Frontend):**
- **OWL (Odoo Web Library)**: framework JS propio, declarativo, inspirado en Vue y React
- Componentes con QWeb templates + directivas OWL
- Sistema de widgets reutilizables
- Desde v15: migración activa al framework OWL; legacy JS en deprecación

**Capa de aplicación (Backend):**
- **Python**: lenguaje principal del servidor (Python 3.10+)
- **Werkzeug**: servidor WSGI/ASGI
- **Odoo ORM**: abstracción de base de datos orientada a objetos
- **Módulos**: unidades de extensión (.py + .xml + assets)

**Capa de datos:**
- **PostgreSQL**: única base de datos soportada oficialmente
- Cada instancia Odoo = una base de datos PostgreSQL
- Multi-tenant: múltiples BDs en el mismo servidor

#### 2.2 Stack Tecnológico Completo

| Capa | Tecnología | Versión |
|------|------------|---------|
| Lenguaje server | Python | 3.10 - 3.12 |
| Framework web server | Werkzeug | 2.x |
| Frontend framework | OWL (Odoo Web Library) | 2.x |
| Template engine | QWeb (XML-based) | Built-in |
| Base de datos | PostgreSQL | 14 - 16 |
| ORM | Odoo ORM (custom) | Built-in |
| Reportes PDF | wkhtmltopdf / WeasyPrint | — |
| Email | smtplib, Mailgun, Postmark | — |
| Assets bundling | esbuild / rollup | — |
| Testing | unittest, Odoo test framework | — |
| CI/CD hosting | Odoo.sh | — |
| Containerización | Docker / Docker Compose | — |
| Proxy reverso | Nginx / HAProxy | — |

#### 2.3 Sistema de Módulos

Un **módulo Odoo** es la unidad mínima de extensión. Estructura:

```
mi_modulo/
├── __manifest__.py        # Metadatos: nombre, deps, versión
├── __init__.py            # Import de sub-paquetes Python
├── models/
│   ├── __init__.py
│   └── mi_modelo.py       # Clases ORM (herencia de models.Model)
├── views/
│   └── mi_modelo_views.xml # Definiciones de vistas (tree, form, kanban)
├── security/
│   ├── ir.model.access.csv # Control de acceso por rol
│   └── security.xml        # Reglas de registro
├── data/
│   └── datos_iniciales.xml # Datos de demostración / configuración
├── static/
│   ├── src/js/            # Componentes OWL y JS
│   └── src/css/           # Estilos
└── controllers/
    └── main.py            # Endpoints HTTP / REST API
```

#### 2.4 Herramientas para el Desarrollador

| Herramienta | Uso | URL |
|-------------|-----|-----|
| **Odoo.sh** | Plataforma CI/CD y hosting gestionado | odoo.sh |
| **Modo Developer** | Activa debug tools en UI | ?debug=1 en URL |
| **OWL Devtools** | Extensión Chrome para debug de componentes OWL | Chrome Store |
| **Runbot** | CI oficial de Odoo (runs tests en cada commit) | runbot.odoo.com |
| **cloc** | Conteo de líneas de código por módulo | CLI |
| **odoo-bin** | CLI principal: init DB, update, shell | python odoo-bin |
| **Odoo Shell** | REPL interactivo con ORM disponible | odoo-bin shell |
| **pgAdmin / DBeaver** | Administración de PostgreSQL | — |
| **VS Code + Python ext** | IDE recomendado para desarrollo Odoo | — |
| **Odoo Scaffolding** | Generador de esqueleto de módulo | odoo-bin scaffold |

#### 2.5 Funcionalidades por Módulo Principal

**Módulos de Negocio (disponibles en Community):**

| Módulo | Descripción | Community | Enterprise |
|--------|-------------|-----------|------------|
| CRM | Gestión de leads, pipeline de ventas | ✅ | ✅+ |
| Ventas | Presupuestos, órdenes de venta, facturación | ✅ | ✅+ |
| Compras | Solicitudes, órdenes de compra, proveedor | ✅ | ✅+ |
| Inventario | Almacenes, movimientos, lotes, rutas | ✅ | ✅+ |
| Contabilidad | Libro mayor, IVA, conciliación | ✅ básico | ✅ avanzado |
| Manufactura | Órdenes de producción, listas de materiales | ✅ | ✅+ |
| Proyecto | Tareas, Kanban, Gantt, horas | ✅ | ✅+ |
| RRHH | Empleados, contratos, departamentos | ✅ básico | ✅ |
| Nómina | Cálculo de salarios, recibos | ❌ | ✅ |
| eCommerce | Tienda online, carrito, pagos | ✅ | ✅+ |
| Website | CMS, constructor de páginas | ✅ | ✅+ |
| Email Marketing | Campañas, segmentación, métricas | ✅ | ✅+ |
| Helpdesk | Tickets, SLA, portal cliente | ❌ | ✅ |
| BI / Spreadsheet | Tablas dinámicas, dashboards | ❌ | ✅ |
| Sign | Firma electrónica de documentos | ❌ | ✅ |
| Fleet | Gestión de vehículos | ✅ | ✅+ |
| Mantenimiento | OT, equipos, preventivo | ✅ | ✅+ |

#### 2.6 Nuevas Características Odoo 18 y 19

**Odoo 18 (Oct 2024) — IA y escalabilidad enterprise:**
- Starter packs por industria (Bakery, Food Truck, Cleaning Service, Marketing Agency, etc.)
- Dispatch Management System (logística con flota propia y 3PL)
- Trazabilidad de lotes/series cross-company
- IA predictiva en manufactura y en análisis de ventas
- Automatización de documentos con OCR mejorado
- Nueva API pública más estable para integraciones

**Odoo 19 (Sep 2025) — AI-first, OWL completo:**
- Migración completa al **OWL framework** en el frontend
- **IA generativa** integrada: generación de flujos de trabajo, auto-completado de datos, guía contextual al usuario en tiempo real
- Integración **Google Merchant Center**, Facebook Shop, TikTok, Gelato (print-on-demand)
- Validación SEO nativa en el website builder
- Shop-floor display rediseñado para manufactura
- **Módulos ESG** (Environmental, Social, Governance) — reporting de sostenibilidad
- Expense Card con sincronización automática
- Bottom-sheet navigation en mobile app
- Helpdesk con tag-based dispatch y automation mejorada

---

### BLOQUE 3 — ACTIVIDADES PRÁCTICAS POR ROLES (25 min)

Los 40 estudiantes se dividen en **5 grupos de 8**, cada grupo representa un departamento de **TechFarma S.A.**

#### Empresa Simulada: TechFarma S.A.

> Startup agroindustrial que produce y vende insumos para agricultura de precisión. Comercializa sensores IoT para campo, kits de análisis de suelo y software de monitoreo. Opera en Argentina, vende a distribuidores y directo a clientes finales (eCommerce).

**Contexto inicial en el sistema:**
- 50 productos cargados (hardware + software + servicios)
- 20 proveedores configurados
- 10 clientes de demo activos
- Contabilidad Argentina configurada

---

#### GRUPO 1 — VENTAS Y CRM (8 estudiantes)

**Rol:** Equipo comercial de TechFarma

**Actividad A — Pipeline de ventas (10 min):**
1. Ingresar a **CRM → Leads/Oportunidades**
2. Crear 3 leads nuevos desde distintas fuentes (manual, formulario web, email)
3. Mover oportunidades por el pipeline Kanban (Nuevo → Calificado → Propuesta → Ganado)
4. Registrar una llamada en el chatter con nota de seguimiento
5. Marcar una oportunidad como "Ganada" y observar la conversión automática a cliente

**Actividad B — Presupuesto y orden de venta (8 min):**
1. Desde la oportunidad ganada, crear un **presupuesto** (Ventas → Presupuestos)
2. Agregar líneas: 5 x "Sensor IoT Suelo Pro" + 1 x "Consultoría Implementación"
3. Aplicar descuento del 10% en la línea de servicio
4. Enviar el presupuesto por email (simulado)
5. Confirmar la orden de venta → observar el flujo a facturación

**Actividad C — Dashboard de ventas (2 min):**
1. Ir a **Reportes → Análisis de ventas**
2. Agrupar por vendedor y mes
3. Comparar pipeline de cada miembro del equipo

**Indicador de éxito:** El grupo debe haber cerrado al menos 2 ventas y facturado USD 15.000+.

---

#### GRUPO 2 — COMPRAS E INVENTARIO (8 estudiantes)

**Rol:** Equipo de supply chain de TechFarma

**Actividad A — Orden de compra (8 min):**
1. Ir a **Compras → Órdenes de Compra**
2. Crear OC para "Microcontroladores ESP32" al proveedor "ElectroComp S.A."
3. Agregar 200 unidades a USD 12 c/u
4. Confirmar la OC y observar el estado del proveedor
5. Registrar la **recepción del material** (validar el albarán de entrada)
6. Verificar el movimiento de stock en **Inventario → Productos**

**Actividad B — Gestión de almacén (10 min):**
1. Crear una **regla de reabastecimiento** (Mínimo 50 unidades de Sensores IoT)
2. Ejecutar el scheduler de reabastecimiento
3. Realizar un **ajuste de inventario** para corregir una diferencia ficticia
4. Generar un movimiento de **transferencia interna** entre ubicaciones
5. Ver el **informe de trazabilidad** de un producto con número de serie

**Actividad C — Análisis de proveedores (2 min):**
1. Reportes → Análisis de compras → Agrupar por proveedor
2. Identificar proveedor con mayor volumen de compra

---

#### GRUPO 3 — MANUFACTURA Y CALIDAD (8 estudiantes)

**Rol:** Equipo de producción de TechFarma

**Actividad A — Lista de materiales (8 min):**
1. Ir a **Manufactura → Listas de Materiales**
2. Revisar la BoM existente: "Kit Sensor IoT Completo"
3. Modificar: agregar "Carcasa Plástica ABS" como componente adicional
4. Crear una **Orden de Producción** para 10 kits
5. Confirmar y ejecutar la producción (marcar componentes como consumidos)
6. Validar la producción → observar el ingreso al inventario

**Actividad B — Operaciones de trabajo (8 min):**
1. Configurar un **Centro de Trabajo** (estación de ensamblaje)
2. Agregar una operación a la BoM: "Ensamblaje" — 30 min/unidad
3. En la orden de producción, registrar el tiempo trabajado
4. Observar el **costo real vs. estimado** en la orden

**Actividad C — Reporte de producción (4 min):**
1. Reportes → Análisis de manufactura
2. Ver eficiencia por orden y comparar con plan

---

#### GRUPO 4 — CONTABILIDAD Y FINANZAS (8 estudiantes)

**Rol:** Equipo financiero de TechFarma

**Actividad A — Facturación (8 min):**
1. Ir a **Contabilidad → Clientes → Facturas**
2. Crear una factura manual para un cliente existente
3. Agregar líneas con IVA (21% Argentina)
4. Validar y confirmar la factura
5. Registrar el **pago** contra la factura
6. Ver la **conciliación bancaria** automática

**Actividad B — Diario contable y reportes (8 min):**
1. Explorar el **Plan de Cuentas** (configurado para Argentina)
2. Ver el **Libro Mayor** de la cuenta "Ventas"
3. Generar el **Balance de sumas y saldos**
4. Ver el **Informe de rentabilidad** (P&L simplificado)
5. Explorar la vista de **flujo de caja**

**Actividad C — Conciliación bancaria (4 min):**
1. Importar un extracto bancario ficticio (CSV provisto)
2. Ejecutar la conciliación automática
3. Resolver una diferencia manual

---

#### GRUPO 5 — RECURSOS HUMANOS Y ADMINISTRACIÓN (8 estudiantes)

**Rol:** Equipo de RRHH y TI de TechFarma

**Actividad A — Alta de empleados (8 min):**
1. Ir a **Empleados → Nuevo Empleado**
2. Crear un empleado completo: datos personales, contrato, departamento, puesto
3. Asignar a un **departamento** (crear si no existe)
4. Configurar el **gestor directo** y estructura jerárquica
5. Crear una **solicitud de tiempo libre** (vacaciones) para el empleado

**Actividad B — Gestión de proyectos internos (10 min):**
1. Ir a **Proyecto → Nuevo Proyecto**: "Implementación CRM 2025"
2. Crear tareas: Planning, Desarrollo, Testing, Go-Live
3. Asignar responsables y fechas
4. Mover tareas por el Kanban
5. Registrar **horas trabajadas** en una tarea
6. Ver el **diagrama de Gantt** del proyecto (Enterprise) o el tablero Kanban (Community)

**Actividad C — Portal de autogestión (2 min):**
1. Acceder al **Portal de empleado** (HR → Portal)
2. Ver sus propias licencias, contratos y recibos

---

### BLOQUE 4 — MÓDULO CUSTOM: ESQUELETO EN VIVO (3 min)

El docente hace live-coding del esqueleto mínimo de un módulo Odoo. Se proyecta el código, los estudiantes pueden seguirlo en la terminal del servidor.

#### Paso 1: Generar scaffold

```bash
# En el servidor Docker
docker exec -it odoo_app bash
cd /mnt/extra-addons
python /usr/lib/python3/dist-packages/odoo/odoo-bin scaffold techfarma_custom .
```

#### Paso 2: Editar `__manifest__.py`

```python
# -*- coding: utf-8 -*-
{
    'name': 'TechFarma Custom',
    'version': '19.0.1.0.0',
    'summary': 'Módulo personalizado para TechFarma S.A.',
    'description': 'Gestión de sensores IoT y contratos de mantenimiento',
    'author': 'Workshop Ingeniería de Sistemas',
    'category': 'Manufacturing',
    'depends': ['base', 'sale_management', 'stock'],
    'data': [
        'security/ir.model.access.csv',
        'views/sensor_views.xml',
    ],
    'installable': True,
    'application': True,
    'license': 'LGPL-3',
}
```

#### Paso 3: Crear el modelo mínimo

```python
# models/sensor.py
from odoo import models, fields, api

class IoTSensor(models.Model):
    _name = 'techfarma.sensor'
    _description = 'Sensor IoT de Campo'

    name = fields.Char(string='Número de Serie', required=True)
    product_id = fields.Many2one('product.product', string='Producto')
    partner_id = fields.Many2one('res.partner', string='Cliente Instalación')
    installation_date = fields.Date(string='Fecha Instalación')
    state = fields.Selection([
        ('draft', 'Borrador'),
        ('active', 'Activo'),
        ('maintenance', 'En Mantenimiento'),
        ('retired', 'Retirado'),
    ], string='Estado', default='draft')
    
    @api.depends('installation_date')
    def _compute_days_active(self):
        for record in self:
            if record.installation_date:
                delta = fields.Date.today() - record.installation_date
                record.days_active = delta.days
            else:
                record.days_active = 0
    
    days_active = fields.Integer(
        string='Días Activo', 
        compute='_compute_days_active'
    )
```

#### Paso 4: Instalar el módulo

```bash
# Actualizar módulos y reiniciar
docker exec odoo_app odoo -c /etc/odoo/odoo.conf -u techfarma_custom --stop-after-init
docker restart odoo_app
```

**Observar en UI:** Ir a Apps → instalar "TechFarma Custom" → explorar el modelo en Configuración → Técnico → Modelos.

---

### BLOQUE 5 — CIERRE Y RECURSOS (2 min)

**Reflexión final (1 min):**
- ¿Qué diferencia a Odoo de implementar módulos separados (CRM, ERP, eCommerce)?
- ¿Cómo impacta la arquitectura open-source en las decisiones de arquitectura de software?
- ¿Cuándo elegirías Odoo vs SAP para un cliente?

**Recursos para seguir aprendiendo (1 min):**

---

## 6. RECURSOS Y BIBLIOGRAFÍA

### Documentación oficial
- Odoo Documentation 19.0: https://www.odoo.com/documentation/19.0/
- Odoo Developer Tutorials: https://www.odoo.com/documentation/19.0/developer/tutorials/
- OWL Framework Docs: https://github.com/odoo/owl
- Odoo GitHub Repository: https://github.com/odoo/odoo

### Libros y papers académicos
- Pinckaers, F. & Gardiner, G. (2013). *Odoo Development Essentials*. Packt Publishing.
- Saura, J.R. (2021). "Open Source ERP: A Systematic Review." *Journal of Open Innovation: Technology, Market, and Complexity*, 7(1), 79.
- Panorama Consulting (2024). *ERP Report 2024: Organizational Value of ERP*. Panorama Consulting Group.
- Gartner (2024). *Magic Quadrant for Cloud ERP for Product-Centric Enterprises*. Gartner, Inc.

### Cursos online
- Odoo eLearning (oficial, gratuito): https://www.odoo.com/slides
- Udemy: "Odoo 18/19 Development" — múltiples autores
- YouTube: OCA (Odoo Community Association) channel

### Comunidades
- OCA (Odoo Community Association): https://odoo-community.org/
- Odoo Forum: https://www.odoo.com/forum/
- Stack Overflow tag `odoo`
- Reddit r/Odoo

### Benchmark y análisis de mercado
- G2 Crowd — Odoo reviews: https://www.g2.com/products/odoo/reviews
- Capterra Odoo: https://www.capterra.com/p/68047/Odoo/
- Gartner Peer Insights — ERP: https://www.gartner.com/reviews/market/erp
- IDC MarketScape: Open Source ERP 2024 (Report IDC #US51963524)

---

## 7. INFRAESTRUCTURA TÉCNICA REQUERIDA

### Para el docente:
- Servidor con Docker y Docker Compose instalado
- Mínimo: 8 GB RAM, 4 vCPU, 50 GB disco SSD
- Recomendado: 16 GB RAM, 8 vCPU (para 40 usuarios concurrentes)
- Acceso SSH al servidor
- IP pública o VPN para acceso de todos los estudiantes

### Para los estudiantes:
- Navegador web moderno (Chrome, Firefox, Edge)
- Acceso a la red del laboratorio / VPN
- (Opcional) VS Code instalado localmente

### Software a pre-instalar en el servidor:
```
Docker Engine 24+
Docker Compose v2
Nginx (reverse proxy)
PostgreSQL 16 (en Docker)
Odoo 19 Community (en Docker)
```

---

## 8. ASIGNACIÓN DE ROLES

| Grupo | Departamento | Roles (8 estudiantes) |
|-------|-------------|----------------------|
| G1 | Ventas & CRM | 2 Vendedores, 1 Gerente, 2 Preventa, 1 Soporte ventas, 2 Analistas |
| G2 | Supply Chain | 2 Compradores, 2 Almacenistas, 1 Gerente SC, 1 Analista, 2 Logística |
| G3 | Manufactura | 2 Operarios, 1 Supervisor, 1 Gerente Planta, 2 QA, 2 Planificación |
| G4 | Finanzas | 2 Contadores, 1 Gerente Financiero, 2 Facturación, 1 Auditor, 2 Tesorería |
| G5 | RRHH & TI | 2 HR, 1 Gerente RH, 1 PM, 2 Desarrolladores, 2 SysAdmin |

**Credenciales de acceso:** Generar con script previo al workshop (ver sección Docker).

---

## 9. MÉTRICAS DE ÉXITO DEL WORKSHOP

| Indicador | Meta |
|-----------|------|
| % estudiantes que completan al menos 2 actividades de su grupo | > 85% |
| % grupos que generan el flujo completo (compra → producción → venta → factura) | > 60% |
| Calificación promedio de la experiencia (encuesta post) | > 4.0 / 5.0 |
| % que instala el módulo custom exitosamente | > 70% |
| % que identifica correctamente las capas de arquitectura de Odoo | > 80% |

---

## 10. EVALUACIÓN SUGERIDA (Opcional — si el workshop es actividad evaluable)

**Rúbrica breve post-workshop (puede ser quiz de 10 minutos):**

| Criterio | Básico (1-2) | Intermedio (3-4) | Avanzado (5) |
|----------|-------------|-----------------|--------------|
| Conceptos ERP | Define ERP genéricamente | Explica integración modular | Compara ERPs con criterios técnicos |
| Arquitectura Odoo | Identifica frontend/backend | Describe OWL, ORM, PostgreSQL | Diseña extensión al stack |
| Navegación | Accede a módulo asignado | Completa flujo de negocio | Navega cross-departmental |
| Módulo custom | Reconoce la estructura | Lee el manifest y el modelo | Modifica el modelo y lo instala |
| Posicionamiento | Menciona open-source | Distingue Community/Enterprise | Argumenta decisión de adopción |

---

*Documento elaborado para uso académico. Workshop diseñado bajo principios de aprendizaje experiencial (Kolb, 1984) y formación de competencias tecnológicas para ingeniería (CDIO Framework, MIT).*

*Versión: 1.0 — Junio 2026*
