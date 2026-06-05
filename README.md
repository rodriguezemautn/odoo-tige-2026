# 🏫 Odoo TIGE 2026 — Workshop de ERP para Ingeniería en Sistemas

> **Workshop universitario de 60 minutos** sobre Odoo ERP, orientado a estudiantes de último año de Ingeniería en Sistemas de Información.
>
> Teoría + práctica inmersiva (empresa simulada) + live coding de un módulo Odoo.

[![Marp](https://img.shields.io/badge/presentación-Marp-6c3aed?style=flat)](docs/02_presentacion_marp.md)
[![Odoo](https://img.shields.io/badge/Odoo-19.0-7c3aed?style=flat)](https://www.odoo.com)
[![License](https://img.shields.io/badge/license-LGPL--3.0-blue?style=flat)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=flat&logo=docker)](docker-compose.yml)

---

## 📋 Descripción

Este proyecto contiene **todo lo necesario** para dictar un workshop universitario de Odoo ERP:

| Componente | Descripción |
|------------|-------------|
| 🎓 **Especificación pedagógica** | Objetivos de aprendizaje, estructura temporal, rúbrica de evaluación, bibliografía |
| 📽️ **Presentación Marp** | 38 slides con tema claro, notas de orador, optimizada para proyector 1366×768 |
| 🐳 **Infraestructura Docker** | Odoo 19 Community + PostgreSQL 16 + Nginx + pgAdmin (opcional) |
| 👥 **Scripts de automatización** | Setup completo, creación de 40 usuarios, carga de datos demo, backups |
| 🧩 **Módulo Odoo completo** | `techfarma_custom` — sensores IoT con modelo ORM, vistas, permisos y datos demo |

### 🏢 Empresa simulada: TechFarma S.A.

Startup agroindustrial argentina que produce y vende sensores IoT para agricultura de precisión. Los 40 estudiantes se dividen en **5 grupos** (8 estudiantes c/u), cada uno operando un departamento real:

| Grupo | Departamento | Flujo |
|-------|-------------|-------|
| 🛒 G1 | Ventas & CRM | Lead → Oportunidad → Presupuesto → Orden de Venta |
| 📦 G2 | Supply Chain | Orden de Compra → Recepción → Stock → Reabastecimiento |
| 🏭 G3 | Manufactura | Lista de Materiales → Orden de Producción → Producto terminado |
| 💰 G4 | Contabilidad | Factura → Pago → Conciliación → Reportes |
| 👥 G5 | RRHH & TI | Alta empleado → Proyecto → Tareas → Portal |

---

## 🚀 Inicio rápido

### Requisitos del servidor

| Recurso | Mínimo | Recomendado |
|---------|--------|-------------|
| CPU | 4 vCPU | 8 vCPU |
| RAM | 8 GB | 16 GB |
| Disco | 50 GB SSD | 100 GB SSD |
| SO | Rocky Linux 9+ / Ubuntu 22.04+ | Rocky Linux 10.2+ |
| Red | Gigabit Ethernet al router | MikroTik recomendado |

### 1. Clonar y configurar

```bash
git clone <repo-url>
cd odoo-tige-2026
cp .env.example .env
# Editar .env con las contraseñas deseadas
```

### 2. Desplegar

```bash
# Setup completo: instala Docker, genera configs, levanta servicios, carga datos, crea usuarios
sudo bash scripts/setup.sh
```

O manualmente:

```bash
docker compose up -d
# Esperar a que todos los servicios estén healthy
docker compose ps
```

### 3. Cargar datos y usuarios

```bash
# Cargar datos demo (productos, proveedores, clientes)
bash scripts/load_demo_data.sh

# Crear los 40 usuarios del workshop
bash scripts/create_users.sh
```

### 4. Presentación

```bash
# Renderizar la presentación (requiere Node.js)
npm install -g @marp-team/marp-cli
marp docs/02_presentacion_marp.md --html -o presentacion.html

# O usar la extensión Marp para VS Code
# Abrir docs/02_presentacion_marp.md → Marp: Export Slide Deck
```

---

## 📁 Estructura del proyecto

```
odoo-tige-2026/
├── README.md                  ← Este archivo
├── docker-compose.yml         ← Orquestación Odoo + PostgreSQL + Nginx
├── .env.example               ← Template de variables de entorno
├── .gitignore
│
├── docs/
│   ├── 01_workshop_spec.md         ← Especificación pedagógica completa
│   ├── 02_presentacion_marp.md     ← Presentación de diapositivas (Marp)
│   └── 03_docker_scenario.md       ← Documentación del escenario Docker
│
├── odoo/
│   ├── odoo.conf                   ← Configuración de Odoo
│   └── extra-addons/
│       └── techfarma_custom/       ← Módulo personalizado del workshop
│           ├── __manifest__.py
│           ├── __init__.py
│           ├── models/sensor.py    ← Modelo ORM con campos, computed, constraints
│           ├── views/sensor_views.xml   ← Vistas tree, form, kanban, search
│           ├── security/
│           │   ├── ir.model.access.csv  ← Permisos CRUD por rol
│           │   └── security.xml         ← Grupos de usuario TechFarma
│           └── data/sensor_demo_data.xml  ← Datos demo (5 sensores)
│
├── nginx/
│   ├── nginx.conf                 ← Configuración global (gzip, seguridad)
│   └── odoo.conf                  ← Virtual host con proxy WebSocket
│
├── postgresql/
│   └── init.sql                   ← Inicialización de BD (uuid-ossp, pg_trgm)
│
├── scripts/
│   ├── setup.sh                   ← Setup completo automatizado
│   ├── create_users.sh            ← Crea 40 usuarios vía XML-RPC
│   ├── load_demo_data.sh          ← Carga productos, proveedores, clientes
│   └── backup.sh                  ← Backup PostgreSQL (pg_dump custom)
│
└── backups/                       ← Directorio para backups (gitignorado)
```

---

## 🧩 Módulo techfarma_custom

Módulo Odoo completo desarrollado para el workshop. Sirve como ejemplo didáctico de:

| Archivo | Concepto |
|---------|----------|
| `__manifest__.py` | Metadatos, dependencias (`base`, `mail`, `product`, `sale_management`) |
| `models/sensor.py` | Modelo ORM: campos básicos, computed fields (`days_active`), constraints, onchange, herencia `mail.thread` |
| `views/sensor_views.xml` | Vistas tree, form, kanban y search |
| `security/ir.model.access.csv` | Permisos CRUD por grupo de usuario |
| `security/security.xml` | Grupos de seguridad TechFarma |
| `data/sensor_demo_data.xml` | 5 sensores de demostración |

---

## 🐳 Servicios Docker

| Servicio | Imagen | Puertos | Descripción |
|----------|--------|---------|-------------|
| **Odoo** | `odoo:19.0` | 8069, 8072 (internos) | Aplicación ERP |
| **PostgreSQL** | `postgres:16-alpine` | 5432 (interno) | Base de datos |
| **Nginx** | `nginx:1.27-alpine` | 80, 443 | Reverse proxy con WebSocket |
| **pgAdmin** | `dpage/pgadmin4` | 5050 (interno) | Admin de BD (perfil `tools`) |

```bash
# Servicios principales
docker compose up -d

# Con pgAdmin (opcional)
docker compose --profile tools up -d
```

---

## 📚 Licencia

- **Contenido del workshop:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
- **Código (módulo Odoo, scripts, configs):** [LGPL-3.0](https://www.gnu.org/licenses/lgpl-3.0.html)
- **Presentación:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

---

## 👤 Autor

**Emanuel Rodriguez** — UTN FrLP — Junio 2026

- GitHub: [@rodriguezemautn](https://github.com/rodriguezemautn)
- Email: erodriguezrodriguez@alu.frlp.utn.edu.ar
