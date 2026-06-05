# 📘 PROJECT.md — Workshop Odoo ERP para Ingeniería en Sistemas

## Descripción General

Este proyecto contiene el diseño completo y los recursos de implementación de un **workshop universitario de 60 minutos** sobre Odoo ERP, orientado a estudiantes de último año de Ingeniería en Sistemas de Información.

El workshop integra tres dimensiones: **teoría** (ERP, historia y arquitectura de Odoo), **práctica inmersiva** (empresa simulada con roles reales en un servidor compartido) y **desarrollo** (creación de un módulo custom en vivo). Todo el entorno corre sobre Docker, replicando condiciones reales de despliegue profesional.

---

## Contexto y Motivación

El mercado global de ERP cloud supera los USD 47.000 millones (Gartner, 2024) y crece al 10% anual. Sin embargo, la mayoría de los egresados de sistemas tienen escasa o nula exposición práctica a estas plataformas durante la carrera. Odoo, construido sobre Python + PostgreSQL + JavaScript, es un punto de entrada ideal: su stack es conocido por los estudiantes, su código es abierto, y su arquitectura modular ilustra con claridad conceptos de diseño de software empresarial.

---

## Estructura del Repositorio

```
taller-odoo/
├── PROJECT.md                       ← Este archivo
├── docker-compose.yml               ← Orquestación Odoo + PostgreSQL + Nginx
├── .env.example                     ← Template de variables de entorno (copiar a .env)
├── .gitignore                       ← Ignorar .env, backups, etc.
│
├── docs/
│   ├── 01_workshop_spec.md          ← Especificación pedagógica completa
│   ├── 02_presentacion_marp.md      ← Presentación de diapositivas (Marp)
│   └── 03_docker_scenario.md        ← Escenario Docker original (referencia)
│
├── odoo/
│   ├── odoo.conf                    ← Configuración de Odoo (generada por setup.sh)
│   └── extra-addons/
│       └── techfarma_custom/        ← Módulo personalizado del workshop
│           ├── __manifest__.py
│           ├── __init__.py
│           ├── models/sensor.py     ← Modelo ORM con campos, computed, constraints
│           ├── views/sensor_views.xml    ← Vistas tree, form, kanban, search
│           ├── security/
│           │   ├── ir.model.access.csv   ← Permisos CRUD por rol
│           │   └── security.xml          ← Grupos de usuario TechFarma
│           └── data/sensor_demo_data.xml ← Datos de demostración (5 sensores)
│
├── nginx/
│   ├── nginx.conf                  ← Configuración global (gzip, seguridad, upstream)
│   └── odoo.conf                   ← Virtual host con proxy WebSocket
│
├── postgresql/
│   └── init.sql                    ← Inicialización de BD (uuid-ossp, pg_trgm)
│
├── scripts/
│   ├── setup.sh                    ← Setup completo: instala Docker, genera configs,
│   │                                  levanta servicios, carga datos, crea usuarios
│   ├── create_users.sh             ← Crea 40 usuarios con grupos Odoo correctos
│   ├── load_demo_data.sh           ← Carga productos, proveedores, clientes
│   └── backup.sh                   ← Backup PostgreSQL con pg_dump custom
│
└── backups/                        ← Directorio para backups (en .gitignore)
```

---

## Entregables

### 1. `01_workshop_spec.md` — Especificación Completa del Workshop

Documento maestro con el diseño pedagógico y el contenido técnico íntegro del workshop.

**Contenido:**

- **Objetivos de aprendizaje** mapeados a la taxonomía de Bloom (6 niveles, desde Comprender hasta Crear)
- **Estructura temporal** en 5 bloques para exactamente 60 minutos
- **Teoría ERP**: historia desde los MRP de los años 60 hasta los ERP AI-native de 2025, características definitorias, diferencias con sistemas aislados
- **Historia de Odoo**: desde TinyERP (2002) hasta Odoo 19 (2025), hitos por versión
- **Versiones y presentaciones**: Community (LGPLv3, gratuita) vs Enterprise (propietaria, ~USD 24.90/usr/mes), modelo de precios 2024
- **Benchmark de mercado**: tabla comparativa con SAP S/4HANA, Oracle Fusion, Microsoft Dynamics 365, NetSuite, ERPNext
- **Posicionamiento Gartner**: análisis honesto — Odoo no integra el Magic Quadrant enterprise pero lidera en Gartner Peer Insights, G2 y Capterra para SME
- **Arquitectura en 3 capas**: presentación (OWL/QWeb), aplicación (Python/Werkzeug/ORM), datos (PostgreSQL)
- **Stack tecnológico completo**: tabla con todas las tecnologías por capa
- **Sistema de módulos**: estructura de archivos, convenciones, manifest, modelos, vistas, seguridad
- **Herramientas del desarrollador**: modo debug, OWL Devtools, odoo-bin scaffold, shell, Odoo.sh, Runbot
- **Funcionalidades por módulo**: tabla Community vs Enterprise para 18 módulos
- **Novedades Odoo 18 y 19**: IA generativa, OWL completo, integrations eCommerce, módulos ESG
- **5 actividades prácticas por grupo** (Ventas & CRM, Supply Chain, Manufactura, Contabilidad, RRHH & TI) con pasos concretos e indicadores de éxito
- **Live coding**: scaffold → modelo ORM → instalación del módulo en vivo
- **Bibliografía académica**: documentación oficial, libros Packt, papers, reportes Gartner e IDC
- **Rúbrica de evaluación** con 5 criterios y 3 niveles de desempeño

---

### 2. `02_presentacion_marp.md` — Presentación de Diapositivas (Marp)

Presentación lista para renderizar con [Marp CLI](https://github.com/marp-team/marp-cli) o la extensión Marp para VS Code.

**Características:**
- **25 slides** con diseño dark profesional (fondo `#0f172a`, acento violeta `#7c3aed`)
- Tipografía system-ui, tablas con zebra striping, layout de dos columnas, bloques de código coloreados
- Una slide por concepto clave: qué es ERP, evolución histórica, historia de Odoo, Community vs Enterprise, benchmark, Gartner, arquitectura, stack, OWL, sistema de módulos, herramientas, novedades 18/19, empresa simulada, 5 slides de actividades por grupo, live coding, recursos

**Cómo renderizar:**
```bash
# Instalar Marp CLI
npm install -g @marp-team/marp-cli

# Exportar a HTML interactivo
marp 02_presentacion_marp.md --html -o presentacion.html

# Exportar a PDF
marp 02_presentacion_marp.md --pdf -o presentacion.pdf
```

---

### 3. Infraestructura Docker (archivos reales en `/`, documentación en `docs/03_docker_scenario.md`)

Infraestructura completa de Odoo 19 Community para desplegar en un servidor Rocky Linux o Ubuntu, con soporte para 40 usuarios concurrentes. A diferencia de la documentación (`03_docker_scenario.md`), acá los archivos son **reales y están listos para deploy**.

**Componentes:**

| Servicio | Imagen | Puerto expuesto |
|----------|--------|-----------------|
| Odoo 19 Community | `odoo:19.0` | 8069 (interno), 8072 WebSocket |
| PostgreSQL 16 | `postgres:16-alpine` | Solo red interna Docker |
| Nginx 1.27 | `nginx:1.27-alpine` | 80 / 443 (público) |
| pgAdmin 4 | `dpage/pgadmin4` | 5050 (interno, perfil tools) |

**Archivos de configuración (listos para deploy):**
- `docker-compose.yml`: orquestación con healthchecks, límites de recursos, red bridge aislada, volúmenes nombrados
- `.env.example`: template de variables de entorno. Copiar a `.env` y editar.
- `odoo/odoo.conf`: workers calibrados, placeholders para contraseñas (generado por `setup.sh`)
- `nginx/nginx.conf`: configuración global con gzip, cabeceras de seguridad, keepalive
- `nginx/odoo.conf`: virtual host con proxy WebSocket, cache de estáticos, `client_max_body_size 64m`
- `postgresql/init.sql`: extensiones `uuid-ossp` y `pg_trgm`

**Scripts listos para ejecutar:**
- `scripts/setup.sh`: setup completo del servidor (Docker, UFW, directorios, genera configs, levanta servicios, carga datos, crea usuarios)
- `scripts/create_users.sh`: crea los 40 usuarios del workshop vía XML-RPC con grupos Odoo **correctamente asignados** (corregido: busca grupos por XML ID, no por nombre mágico)
- `scripts/load_demo_data.sh`: carga 12 productos, 5 proveedores, 10 clientes de TechFarma S.A.
- `scripts/backup.sh`: dump de PostgreSQL con `pg_dump --format=custom --compress=9`

**Módulo Odoo completo** (`odoo/extra-addons/techfarma_custom/`):
- `__manifest__.py`: metadatos, dependencias (`base`, `mail`, `product`, `sale_management`)
- `models/sensor.py`: modelo `techfarma.sensor` con campos básicos, computed fields (`days_active`, `is_overdue`), constraints, onchange, herencia de `mail.thread` para chatter
- `views/sensor_views.xml`: vistas tree, form, kanban y search **completas** (esto faltaba en la documentación original)
- `security/ir.model.access.csv`: permisos CRUD para usuarios y managers
- `security/security.xml`: grupos de seguridad TechFarma
- `data/sensor_demo_data.xml`: 5 sensores de demostración precargados

**Requisitos de servidor:**
- Mínimo: 4 vCPU / 8 GB RAM / 50 GB SSD
- Recomendado: 8 vCPU / 16 GB RAM / 100 GB SSD
- OS: Rocky Linux 9+ o Ubuntu 22.04+ (testeado en Rocky Linux 10.2)
- Red: conexión Gigabit Ethernet al router (MikroTik recomendado)

---

## Empresa Simulada: TechFarma S.A.

Todos los grupos trabajan sobre la misma instancia Odoo, operando como departamentos de una startup ficticia.

> Startup agroindustrial argentina que produce y vende sensores IoT para agricultura de precisión, kits de análisis de suelo, software de monitoreo SaaS y servicios de consultoría. Opera en Argentina y vende a distribuidores LATAM y clientes finales vía eCommerce.

**Datos precargados:** 12 productos (hardware + software + servicios), 5 proveedores, 10 clientes, contabilidad Argentina configurada.

**Distribución de roles:**

| Grupo | Departamento | Flujo principal |
|-------|-------------|-----------------|
| G1 (8 estudiantes) | Ventas & CRM | Lead → Oportunidad → Presupuesto → Orden de Venta |
| G2 (8 estudiantes) | Supply Chain | OC → Recepción → Stock → Reabastecimiento |
| G3 (8 estudiantes) | Manufactura | BoM → Orden de Producción → Calidad → Inventario |
| G4 (8 estudiantes) | Contabilidad | Factura → Pago → Conciliación → Reportes |
| G5 (8 estudiantes) | RRHH & TI | Empleados → Proyecto → Tareas → Portal |

---

## Decisiones de Diseño

**¿Por qué Odoo 19 Community y no Enterprise?**
Community es suficiente para cubrir todos los conceptos del workshop, no requiere licencia, y es la versión que los estudiantes pueden desplegar por su cuenta luego. La presentación explica las diferencias con Enterprise para que entiendan el modelo comercial completo.

**¿Por qué Docker Compose y no instalación nativa?**
Docker Compose replica el entorno de despliegue real más habitual en producción SME, permite reset limpio entre ediciones del workshop, y expone a los estudiantes a un stack DevOps concreto (Nginx, PostgreSQL, healthchecks, volúmenes nombrados).

**¿Por qué una empresa ficticia con roles?**
El aprendizaje experiencial (Kolb, 1984) es más efectivo cuando el contexto es concreto y el estudiante tiene un rol definido. Operar como "Contador de TechFarma" es más motivador que "hacer click en el módulo de contabilidad". El flujo compartido entre grupos también ilustra la integración transversal, la principal virtud de un ERP.

**¿Por qué live coding del módulo y no solo teoría?**
Desmitificar el desarrollo sobre Odoo es uno de los objetivos clave. Ver en 3 minutos que un modelo funcional tiene menos de 40 líneas de Python elimina la percepción de barrera técnica y abre la puerta a que los estudiantes exploren el desarrollo por su cuenta.

---

## Stack del Proyecto

| Capa | Tecnología |
|------|------------|
| ERP | Odoo 19.0 Community |
| Backend | Python 3.12 |
| Frontend | OWL (Odoo Web Library) + QWeb |
| Base de datos | PostgreSQL 16 |
| Contenedores | Docker 24+ / Docker Compose v2 |
| Proxy reverso | Nginx 1.27 |
| Presentación | Marp (Markdown Presentation Ecosystem) |
| Documentación | Markdown |

---

## Referencias

- Odoo Documentation 19.0 — https://www.odoo.com/documentation/19.0/
- Gartner Magic Quadrant for Cloud ERP for Product-Centric Enterprises, 2024
- Gartner Peer Insights — ERP Reviews, 2025
- IDC MarketScape: Open Source ERP 2024 (Report #US51963524)
- Kolb, D.A. (1984). *Experiential Learning*. Prentice Hall.
- CDIO Framework — MIT Engineering Education
- OEC.sh Guides — Odoo Docker Compose (Feb 2026)
- OWL Documentation — https://github.com/odoo/owl

---

*Versión: 1.0 — Junio 2026*  
*Autor: Workshop de Ingeniería en Sistemas de Información*  
*Licencia de los materiales: CC BY-SA 4.0 (contenido) / LGPL-3 (código Odoo)*
