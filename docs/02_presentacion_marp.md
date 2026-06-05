---
marp: true
theme: default
class:
  - lead
paginate: true
backgroundColor: '#ffffff'
color: '#1e1e2e'
style: |
  /* ═══════════════════════════════════════════════════════
     TEMA CLARO — v4.0 — MÁS GRANDE, SIN CENTRADO EN BOXES
     ═══════════════════════════════════════════════════════
     Fuentes todavía más grandes. Texto siempre left en boxes,
     columnas, código y estructuras de árbol.
     ═══════════════════════════════════════════════════════ */

  /* ── Base ─────────────────────────────────── */
  section {
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    background-color: #ffffff;
    color: #1e1e2e;
    padding: 12px 20px;
    width: 1280px;
    height: 720px;
    justify-content: flex-start;
    font-size: 1.35rem;
    line-height: 1.25;
  }
  section.lead {
    text-align: center;
    justify-content: center;
  }

  /* ── Headers ──────────────────────────────── */
  h1 { color: #6c3aed; font-size: 2.4rem; margin: 0 0 0.06em 0; font-weight: 700; }
  h2 { color: #6c3aed; font-size: 1.6rem; border-bottom: 2px solid #6c3aed30; padding-bottom: 2px; margin: 0.06em 0 0.15em 0; font-weight: 600; }
  h3 { color: #4a1a9e; font-size: 1.35rem; margin: 0.1em 0; font-weight: 600; }
  h4 { color: #1e1e2e; font-size: 1.15rem; margin: 0.06em 0; font-weight: 600; }

  /* ── Text ─────────────────────────────────── */
  p { line-height: 1.25; margin: 0.1em 0; }
  strong { color: #6c3aed; font-weight: 700; }
  ul, ol { line-height: 1.25; margin: 0.04em 0; padding-left: 0.9em; }
  li { margin-bottom: 0.03em; }

  /* ── Code ─────────────────────────────────── */
  code {
    background: #f1f5f9;
    color: #1e1e2e;
    padding: 1px 4px;
    border-radius: 3px;
    font-size: 0.95rem;
    font-family: 'Cascadia Code', 'Fira Code', 'JetBrains Mono', monospace;
    border: 1px solid #e2e8f0;
    text-align: left !important;
  }
  pre {
    background: #f8fafc;
    border-left: 3px solid #6c3aed;
    padding: 5px 8px;
    border-radius: 5px;
    font-size: 0.9rem;
    line-height: 1.2;
    margin: 0.1em 0;
    border: 1px solid #e2e8f0;
    overflow-x: auto;
    max-height: none;
    text-align: left !important;
  }
  pre code {
    background: transparent;
    padding: 0;
    border: none;
    font-size: inherit;
    white-space: pre;
    word-break: normal;
    overflow-wrap: normal;
  }

  /* ── Tables ───────────────────────────────── */
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.85rem;
    margin: 0.1em 0;
    border: 1px solid #e2e8f0;
    border-radius: 5px;
    overflow: hidden;
  }
  th {
    background: #6c3aed;
    color: #ffffff;
    padding: 2px 5px;
    font-weight: 600;
    text-align: left;
    font-size: 0.8rem;
  }
  td {
    padding: 2px 5px;
    border-bottom: 1px solid #e2e8f0;
    color: #1e1e2e;
    text-align: left;
  }
  tr:nth-child(even) { background: #f8fafc; }

  /* ── Layout — FORZAR left en columnas ────── */
  .columns { display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem; }
  .columns-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 0.5rem; }
  .columns > div, .columns-3 > div { text-align: left !important; }

  /* ── Highlight boxes ──────────────────────── */
  .highlight {
    background: #f8fafc;
    border-left: 3px solid #6c3aed;
    padding: 4px 8px;
    border-radius: 5px;
    margin: 0.1em 0;
    border: 1px solid #e2e8f0;
    font-size: 1.1rem;
    text-align: left !important;
  }
  .tip {
    background: #ecfdf5;
    border-left: 3px solid #10b981;
    padding: 4px 8px;
    border-radius: 5px;
    margin: 0.1em 0;
    border: 1px solid #a7f3d0;
    font-size: 1.1rem;
    text-align: left !important;
  }
  .warning {
    background: #fffbeb;
    border-left: 3px solid #f59e0b;
    padding: 4px 8px;
    border-radius: 5px;
    margin: 0.1em 0;
    border: 1px solid #fde68a;
    font-size: 1.1rem;
    text-align: left !important;
  }

  /* ── Badges ───────────────────────────────── */
  .badge {
    display: inline-block;
    background: #6c3aed;
    color: #ffffff;
    padding: 1px 7px;
    border-radius: 999px;
    font-size: 0.85rem;
    font-weight: 600;
  }
  .badge-green { background: #10b981; }
  .badge-orange { background: #f59e0b; }
  .badge-red { background: #ef4444; }

  /* ── Footer ───────────────────────────────── */
  footer { color: #94a3b8; font-size: 0.8rem; }

  /* ── Lead / Centered ──────────────────────── */
  section.lead h1 { font-size: 2.6rem; }
  section.lead h2 { border: none; font-size: 1.6rem; color: #475569; }
  section.lead p { font-size: 1.35rem; color: #64748b; }

  /* ── Small text ───────────────────────────── */
  .small { font-size: 0.95rem; color: #64748b; text-align: left !important; }

  /* ── Arrow flow ───────────────────────────── */
  .flow {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 3px;
    font-size: 1.35rem;
    font-weight: 600;
    color: #6c3aed;
    margin: 4px 0;
  }
  .flow span { background: #f1f5f9; padding: 2px 7px; border-radius: 6px; color: #1e1e2e; font-weight: 500; font-size: 0.95rem; text-align: left !important; }
  .flow .arrow { color: #6c3aed; font-size: 1rem; }

  /* ── Feature grid ─────────────────────────── */
  .feature-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3px;
    margin: 0.1em 0;
  }
  .feature-item {
    background: #f8fafc;
    padding: 3px 7px;
    border-radius: 5px;
    border: 1px solid #e2e8f0;
    font-size: 0.95rem;
    line-height: 1.2;
    text-align: left !important;
  }
  .feature-item strong { display: block; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; color: #6c3aed; }

  /* ── Big number stats ──────────────────────── */
  .stat-row {
    display: flex;
    justify-content: space-around;
    margin: 3px 0;
  }
  .stat { text-align: center; }
  .stat .number {
    font-size: 1.8rem;
    font-weight: 800;
    color: #6c3aed;
    display: block;
  }
  .stat .label {
    font-size: 0.95rem;
    color: #64748b;
  }

  /* ── Checkbox list ────────────────────────── */
  ul.task-list { list-style: none; padding-left: 0; }
  ul.task-list li { padding-left: 1.2em; text-indent: -1.2em; }
---

<!-- _class: lead -->

# Odoo ERP
## De la Teoría a la Práctica en 60 Minutos

**Workshop · Ingeniería en Sistemas de Información**

Emanuel Rodriguez · UTN FrLP · Junio 2026

> *"El mejor ERP es el que tu equipo realmente usa"*

<!--
Bienvenidos. En los próximos 60 minutos vamos a recorrer el mundo de los ERP
con Odoo como protagonista. La dinámica va a ser: conceptos primero, después
arquitectura, y luego todos a practicar en un Odoo real.

Tienen que saber que esto no es una charla magistral — al final, ustedes van
a estar operando una empresa real en un sistema real. Así que pregunten todo
lo que quieran.

Presentarme: soy Emanuel, vengo del mundo del desarrollo de software empresarial.
-->
---

<!-- _footer: "Workshop Odoo · Ingeniería en Sistemas · 2026" -->

# 🗺️ Agenda del Workshop

<div class="columns">
<div>

| # | Bloque | Tiempo |
|---|--------|--------|
| 0 | Bienvenida y setup de entorno | 5 min |
| 1 | ERP: Conceptos, historia, mercado | 15 min |
| 2 | Odoo: Arquitectura y stack técnico | 10 min |
| 3 | **Práctica por roles (empresa simulada)** | **25 min** |
| 4 | Desarrollo y monetización de módulos | 3 min |
| 5 | Cierre y recursos | 2 min |

</div>
<div>

**Empresa simulada:** TechFarma S.A.

> Startup agroindustrial argentina que produce sensores IoT para agricultura de precisión.

🔐 **Server:** `http://odoo.workshop.local`
👤 **Login:** por grupo asignado
🕐 **Tiempo de práctica:** 25 min

**Regla de oro:** Hoy todos son empleados de TechFarma. Operen como si fuera su primer día en el puesto.

</div>
</div>

<!--
Esta es la hoja de ruta. El bloque más importante —y el más divertido— es el
Bloque 3, donde ustedes van a operar la empresa. No se preocupen si no terminan
todo. La idea es que entiendan el flujo completo.

La empresa simulada es TechFarma S.A. — una startup agroindustrial que produce
sensores IoT. ¿Por qué una empresa ficticia? Porque cuando tenés un rol definido
—"hoy soy el contador de TechFarma"— el aprendizaje es mucho más efectivo.

La URL se la paso al docente para que la proyecte. Los logins dependen del rol
de cada uno.
-->
---

# 🏢 ¿Qué es un ERP?

> Un **ERP** (*Enterprise Resource Planning*) es un sistema de software integrado que permite gestionar y automatizar todos los procesos de negocio de una organización mediante una **base de datos única y centralizada**.

<div class="columns">
<div>

### ❌ Sin ERP — Silos de información

```
Ventas →   [CRM separado]
Compras →  [Excel / papel]
Stock →    [Sistema legacy]
Caja →     [Otro sistema]
RRHH →     [Planilla aparte]
```

**Problemas:** datos duplicados, errores de tipeo, reportes manuales, decisiones lentas.

</div>
<div>

### ✅ Con ERP — Una sola fuente de verdad

```
┌──────────────────────────────────┐
│          ERP (única BD)          │
├──────────────────────────────────┤
│ Ventas │ Stock │ Caja │ RRHH     │
│ Compras│ Prod  │ CRM  │ Proy     │
└──────────────────────────────────┘
```

**Beneficios:** datos consistentes, flujos integrados, trazabilidad total, reportes en tiempo real.

</div>
</div>

<!--
Pregunta inicial: ¿alguno trabajó con un ERP o con sistemas integrados?

La idea central de un ERP es simple: TODOS los datos de la empresa viven en
una sola base de datos. Cuando un vendedor hace una venta, automáticamente
se actualiza el stock, se genera la factura, y el comprador ve que falta
reponer. Sin intervention manual.

Sin ERP, cada departamento tiene su propio sistema — ventas usa un CRM,
compras usa Excel, contabilidad usa otro sistema. Y después alguien tiene
que conciliar todo a fin de mes. Eso es ineficiente y propenso a errores.

Con un ERP, todo está integrado. Es como pasar de tener 5 radios sintonizadas
en distintas frecuencias a tener una central de comunicaciones única.
-->
---

# 📅 Evolución de los ERP

```
1960s ── MRP (Material Requirements Planning)
         │ IBM para manufactura. ¿Cuánto material necesito?
         │
1970s ── MRP II (Manufacturing Resource Planning)
         │ Incorpora finanzas, capacidad de planta, simulación
         │
1990s ── 🏷️ Nace el término "ERP" (Gartner, 1990)
         │ SAP R/3 domina el mercado enterprise global
         │
2000s ── ERP web-based. Oracle adquiere PeopleSoft (2005)
         │ El ERP sale de la intranet corporativa
         │
2010s ── Cloud ERP / SaaS ERP
         │ Workday, NetSuite, Odoo — ERPs como servicio
         │
2020s ── AI-native ERP · Composable ERP · Open Source ERP
         │ ERP con IA generativa integrada, módulos ESG
```

<div class="highlight">

**Mercado global de Cloud ERP 2024:** USD **47.000 millones** — creciendo al **10% anual** (Gartner)

</div>

<!--
Hagamos un viaje rápido por la historia de los ERP.

Arranca en los 60 con los MRP — sistemas de planificación de materiales para
manufactura. Básicamente respondían "¿cuánto material necesito para producir X?"

En los 90, Gartner acuña el término ERP y SAP se vuelve el rey indiscutido
del mercado enterprise. Instalar SAP era un proyecto de 2 años y millones de
dólares.

En los 2010s aparece el ERP en la nube. Ya no necesitás un datacenter propio.
Y acá es donde entran jugadores como Odoo.

El mercado hoy mueve 47 mil millones de dólares y crece 10% anual. Es enorme.
Y hay un hueco gigante para ERPs accesibles para PyMEs — que es exactamente
donde apunta Odoo.
-->
---

# 🟣 Historia de Odoo

<div class="columns">
<div>

| Año | Hito |
|-----|------|
| **2002** | Fabien Pinckaers funda **TinyERP** en Bélgica |
| **2005** | Primera versión pública (1.0) |
| **2009** | Rebrand → **OpenERP** — explota popularidad |
| **2010** | OpenERP 6.0 — arquitectura modular madura |
| **2014** | Rebrand → **Odoo** 8.0 |
| **2015** | Odoo 9.0 — separación Community / Enterprise |
| **2018** | Odoo 12 — ORM renovado, performance PostgreSQL |
| **2020** | Odoo 14 — nueva UI, Discuss rediseñado |
| **2023** | Odoo 17 — último release open-source irrestricto |
| **2024** | **Odoo 18** — IA generativa, nuevo pricing |
| **2025** | **Odoo 19** — OWL completo, AI-first, ESG |
| **2026** | **Odoo 20** esperado (Odoo Experience, Sep 2026) |

</div>
<div>

### 📊 Odoo hoy (2025)

<div class="stat-row">
  <div class="stat">
    <span class="number">12M+</span>
    <span class="label">usuarios activos</span>
  </div>
  <div class="stat">
    <span class="number">44K+</span>
    <span class="label">apps en la tienda</span>
  </div>
  <div class="stat">
    <span class="number">3K+</span>
    <span class="label">partners certificados</span>
  </div>
</div>

**Datos clave:**
- 🌍 Usuarios en **180+ países**
- 👤 **Fabien Pinckaers** sigue siendo CEO
- 🏢 HQ: Ramillies, **Bélgica**
- 📜 Licencia: **LGPLv3** (Community)
- 🐍 Stack: **Python + PostgreSQL + OWL**

</div>
</div>

<!--
La historia de Odoo arranca en 2002 en Bélgica. Fabien Pinckaers, un
emprendedor belga, crea TinyERP porque no encontraba un ERP accesible
para PyMEs.

En 2009 el proyecto explota y se rebrandea a OpenERP. Para 2014 ya
era tan grande que necesitaban un nombre más global: nace Odoo.

Un dato importante: Fabien sigue siendo CEO hoy. Eso es raro en el
mundo del software — el fundador todavía lidera la empresa 20+ años
después.

Hoy Odoo tiene 12 millones de usuarios, 44 mil aplicaciones en su
tienda, y 3 mil partners certificados globalmente. Es el ERP open-source
líder del mundo, punto.
-->
---

# 🆚 Odoo Community vs Enterprise

| Característica | Community | Enterprise |
|---------------|-----------|------------|
| **Licencia** | LGPLv3 (open-source total) | Propietaria |
| **Precio** | **Gratuito** | Desde USD 24.90/usr/mes |
| **Soporte** | Comunidad / Foros | Oficial con SLA |
| **Hosting** | Auto-hosted | Odoo.sh incluido |
| **App móvil** | ❌ No incluye | ✅ iOS + Android nativas |
| **Módulos clave** | CRM, Ventas, Compras, Inventario, Contab. básica, Manufactura, Proyecto, RRHH básico, eCommerce, Website | Todo lo de Community + Nómina, Helpdesk, BI, Firma Electrónica, Fleet |
| **Multi-empresa** | Manual | Nativo |

<div class="tip">

**🎯 Hoy usamos:** Odoo **19 Community** desplegado en Docker. Es suficiente para cubrir ABSOLUTAMENTE todos los conceptos del workshop y pueden instalarlo ustedes después sin costo.

</div>

<!--
Esta es una pregunta que siempre surge: ¿Community o Enterprise?

Community es 100% gratuita, con licencia LGPLv3 — pueden modificarla,
venderla, redistribuirla. Lo único que no tiene son algunos módulos
avanzados como nómina, helpdesk o BI.

Enterprise cuesta desde USD 24.90 por usuario por mes e incluye soporte,
hosting gestionado (Odoo.sh), app mobile, y módulos extra.

Para el workshop usamos Community porque:
1. Es suficiente para cubrir todos los conceptos
2. No requiere licencia
3. Es lo que ustedes pueden instalar en su casa después

Y ojo: Community NO es una versión "trucha" o limitada. El core de Odoo
es el mismo. La diferencia está en los módulos avanzados y el soporte.
-->
---

# 📊 Benchmark ERP 2025

| ERP | Segmento | Precio base | Modelo | Fortaleza clave |
|-----|----------|------------|--------|-----------------|
| **SAP S/4HANA** | Enterprise | USD 1.800+/usr/año | Cloud/On-prem | Manufactura compleja, global |
| **Oracle Fusion** | Enterprise | USD 1.600+/usr/año | Cloud | Finanzas, Supply Chain |
| **Microsoft D365** | Mid-market | USD 180/usr/mes | Cloud | Integración M365 + Copilot AI |
| **NetSuite** | Mid-market | USD 999+/mes base | SaaS | Contabilidad multi-moneda |
| **Odoo Enterprise** | SME → Mid | **USD 24.90/usr/mes** | Cloud/On-prem | **Precio + modularidad** |
| **Odoo Community** | SME | **Gratuito** | On-prem | Personalización sin costo |
| **ERPNext** | SME | Gratuito | SaaS/OSS | Muy abierto, comunidad activa |
| **Dolibarr** | Micro-SME | Gratuito | OSS | Simple, fácil de empezar |

<div class="highlight">

💰 **TCO (Total Cost of Ownership) de Odoo es 60-80% menor que SAP/Oracle** — implementación en semanas, no meses/años

</div>

<!--
Miremos el panorama competitivo.

En el segmento enterprise dominan SAP y Oracle — son sistemas de millones
de dólares que tardan 1-2 años en implementarse.

En mid-market está Microsoft D365 y NetSuite. Más accesibles, pero siguen
siendo costosos.

Y acá está Odoo: 24.90 dólares por usuario por mes. Versus los 180 de
Microsoft o los 1.800/año de SAP. La diferencia es abismal.

¿Por qué es tan barato? Porque el core es open-source y la empresa genera
ingresos por servicios (hosting, soporte, enterprise). Es el mismo modelo
de Red Hat, GitLab, o WordPress.

Un dato importante: Odoo no compite directamente con SAP en empresas
multinacionales de 10 mil empleados. Compite en el segmento PyME y
mid-market, que es el 90% de las empresas del mundo.
-->
---

# 📐 Posicionamiento en el Mercado

<div class="columns">
<div>

### Gartner Magic Quadrant 2024-2025

**Líderes:** Oracle, SAP, Microsoft, Epicor, Infor

**⚠️ Odoo NO aparece en el Magic Quadrant** — no cumple los criterios de revenue y base enterprise que exige Gartner.

**Sin embargo, en otros rankings:**

| Fuente | Puntaje |
|--------|---------|
| Gartner Peer Insights | ⭐ 4.2/5 |
| G2 Crowd | ⭐ 4.2/5 (10K+ reviews) |
| Capterra | ⭐ 4.1/5 |
| Forrester | Strong Performer (SME) |
| IDC MarketScape | Referente open-source ERP 2024 |

</div>
<div>

### Ventajas competitivas de Odoo

<div class="feature-grid">
  <div class="feature-item">
    <strong>💰 Costo</strong>
    TCO 60-80% menor que SAP/Oracle
  </div>
  <div class="feature-item">
    <strong>⚡ Velocidad</strong>
    Implementación en semanas, no meses
  </div>
  <div class="feature-item">
    <strong>🧩 Modularidad</strong>
    Empezás con 1 app, crecés sin reemplazar
  </div>
  <div class="feature-item">
    <strong>🔓 Open Source</strong>
    Sin vendor lock-in. Tu código, tus datos
  </div>
  <div class="feature-item">
    <strong>🐍 Stack moderno</strong>
    Python + OWL + PostgreSQL = conocido por devs
  </div>
  <div class="feature-item">
    <strong>🌐 Comunidad</strong>
    44K+ módulos, contribuciones globales
  </div>
</div>

### ¿Cuándo NO elegir Odoo?

- Empresa > 1.000 empleados con procesos ultra-complejos
- Industria con regulaciones muy específicas (defensa, aeroespacial)
- Si necesitás soporte 24/7 con penalidades contractuales

</div>
</div>

<!--
Acá quiero ser honesto con ustedes — y esto es importante.

Odoo NO está en el Cuadrante Mágico de Gartner para ERP enterprise.
Si buscan el análisis más conocido del mercado, no lo van a encontrar.
¿Por qué? Porque Gartner exige ciertos niveles de facturación y base
instalada enterprise que Odoo todavía no alcanza.

PERO — y esto es un pero grande — en Gartner Peer Insights (que son
review de usuarios reales), Odoo tiene 4.2/5 estrellas. En G2 y
Capterra también.

¿Qué significa esto? Que si bien Odoo no es un ERP para multinacionales
de 10 mil empleados, para el 90% de las empresas del mundo —las PyMEs—
es la mejor opción calidad-precio del mercado.

Las ventajas: costo 60-80% menor, implementación en semanas vs meses,
modularidad real, y sobre todo: open-source. No hay vendor lock-in.
-->
---

# 🏗️ Arquitectura de Odoo — 3 Capas

```
                    ┌──────────────────────────────────────────────┐
                    │         CAPA DE PRESENTACIÓN (Frontend)       │
                    │                                               │
                    │   🌐 Navegador Web           📱 App Móvil     │
                    │   ┌──────────────────────┐  ┌──────────────┐ │
                    │   │  OWL Framework (JS)  │  │  Odoo Mobile │ │
                    │   │  QWeb Templates      │  │  (Enterprise)│ │
                    │   │  RPC JSON · WS 8072  │  │              │ │
                    │   └──────────────────────┘  └──────────────┘ │
                    └──────────────────────┬───────────────────────┘
                                           │ HTTP/HTTPS (puerto 8069)
                    ┌──────────────────────▼───────────────────────┐
                    │        CAPA DE APLICACIÓN (Backend)          │
                    │                                               │
                    │   🐍 Python 3.10+ · Werkzeug (WSGI server)   │
                    │   📦 Odoo ORM (abstracción de BD)            │
                    │   🧩 MÓDULOS: modelos .py + vistas .xml      │
                    │   ⏰ Cron jobs · 📧 Email engine              │
                    │   📄 Reportes PDF · 🔌 OpenRPC / REST API    │
                    └──────────────────────┬───────────────────────┘
                                           │ Queries SQL (solo vía ORM)
                    ┌──────────────────────▼───────────────────────┐
                    │           CAPA DE DATOS (Database)           │
                    │                                               │
                    │   🗄️ PostgreSQL 14-16                        │
                    │   🔑 Esquema por base de datos               │
                    │   🔒 Acceso exclusivo vía ORM                │
                    │   📊 Multi-tenant: múltiples BDs             │
                    └──────────────────────────────────────────────┘
```

**Patrón arquitectónico:** MVC + ORM + Sistema de módulos cargados dinámicamente

<!--
La arquitectura de Odoo es de 3 capas, y quiero que le presten atención
porque es un ejemplo clásico de arquitectura de software bien hecha.

Capa 1 — Frontend: Acá conviven OWL, el framework JS propio de Odoo
(declarativo, inspirado en Vue y React), con QWeb que es su sistema de
templates XML. La comunicación con el backend es vía RPC JSON y WebSocket
para las actualizaciones en tiempo real.

Capa 2 — Backend: Python puro. Werkzeug como servidor HTTP, el ORM de
Odoo que abstrae toda la base de datos, y los módulos que son la unidad
fundamental de extensión. Todo en Odoo es un módulo — incluso el núcleo.

Capa 3 — Datos: PostgreSQL, la única base de datos soportada oficialmente.
Cada instancia de Odoo es una base de datos PostgreSQL separada.

El patrón es MVC: los modelos Python definen la estructura de datos, las
vistas XML definen la UI, y los controladores manejan la lógica.
-->
---

# 🛠️ Stack Tecnológico de Odoo 19

<div class="columns-3">
<div>

### Backend

| Tecnología | Versión |
|------------|---------|
| 🐍 **Python** | 3.10 - 3.12 |
| ⚙️ **Werkzeug** | 2.x (WSGI) |
| 🗄️ **PostgreSQL** | 14 - 16 |
| 🔧 **Odoo ORM** | Propietario |
| 📦 **Odoo Modules** | .py + .xml |

</div>
<div>

### Frontend

| Tecnología | Versión |
|------------|---------|
| 🦉 **OWL** | 2.x (Framework JS) |
| 📝 **QWeb** | Templates XML |
| 🎨 **Bootstrap** | 5.x |
| 📦 **esbuild** | Bundler |
| 🧩 **OWL Devtools** | Chrome ext. |

</div>
<div>

### DevOps & Más

| Tecnología | Uso |
|------------|-----|
| 🐳 **Docker** | Contenedores |
| 🌐 **Nginx** | Reverse proxy |
| 🚀 **Odoo.sh** | CI/CD hosting |
| 📄 **wkhtmltopdf** | Reportes PDF |
| 🧪 **unittest** | Testing Python |
| ☁️ **AWS / GCP / Azure** | Cloud |

</div>
</div>

<br>

<div class="tip">

**💡 Dato clave:** Python + PostgreSQL son tecnologías que ustedes YA conocen de la carrera. La curva de aprendizaje de Odoo es más corta justamente porque el stack les es familiar.

</div>

<!--

El stack de Odoo es moderno y conocido. ¿Por qué es importante esto?
Porque si ustedes ya saben Python y PostgreSQL —que lo saben— ya tienen
el 70% del camino recorrido para desarrollar sobre Odoo.

El frontend usa OWL, un framework JS propio que tiene conceptos similares
a React o Vue: componentes, estado, templates. Pero está optimizado
específicamente para las necesidades de un ERP.

Para el workshop, el stack que nos importa es: Docker para levantar todo,
Python para los modelos, XML para las vistas, y el ORM de Odoo para
interactuar con la base de datos.
-->
---

# 🦉 OWL — El Framework Frontend de Odoo

> **OWL (Odoo Web Library):** Framework JavaScript declarativo, liviano (~15KB), inspirado en Vue y React. Desde Odoo 19, **migración COMPLETA** al OWL.

<div class="columns">
<div>

### Conceptos clave

- **Componentes:** clases que extienden `owl.Component`
- **Templates:** XML con directivas `t-*`
- **Reactividad:** `useState()` para estado local
- **Props:** comunicación padre → hijo
- **Hooks:** `onMounted`, `onWillUpdate`, etc.
- **OWL Devtools:** extensión Chrome para debug

### Ciclo de vida

```
setup() → willStart() → mounted() → 
onWillUpdateProps() → patched() → 
onWillUnmount()
```

</div>
<div>

### Ejemplo: Componente Sensor Card

```javascript
/** @package techfarma_custom */
import { Component, useState, xml } from "@odoo/owl";

class SensorCard extends Component {
  static template = xml`
    <div class="sensor-card">
      <h3 t-esc="props.sensor.name"/>
      <span class="badge"
            t-att-class="'badge-' + props.sensor.state">
        <t t-esc="props.sensor.state"/>
      </span>
      <p>Días activo: <t t-esc="props.sensor.days_active"/></p>
    </div>
  `;

  setup() {
    this.state = useState({ expanded: false });
  }

  toggle() {
    this.state.expanded = !this.state.expanded;
  }
}
```

</div>
</div>

<!--
OWL es el framework JavaScript que Odoo construyó para su frontend.
¿Por qué no usaron React o Vue? Porque necesitaban algo:
1. Liviano — un ERP tiene que cargar rápido
2. Integrado con QWeb que ya usaban
3. Con reactividad pero sin dependencias externas

Desde Odoo 19, el frontend está 100% migrado a OWL. Ya no queda
casi nada del JS legacy.

La sintaxis les va a resultar familiar si vieron React — componentes,
props, estado — pero es mucho más simple. Un componente OWL puede
tener template, estado, y métodos en menos de 50 líneas.

Y tienen OWL Devtools, una extensión de Chrome que permite inspeccionar
componentes como React Devtools.
-->
---

# 📦 Sistema de Módulos de Odoo

## Todo en Odoo es un módulo — incluso el núcleo (`base`)

```
mi_modulo/
│
├── __manifest__.py        ← Metadatos: nombre, versión, dependencias, archivos
├── __init__.py            ← Init de Python (importa modelos, controllers)
│
├── models/
│   ├── __init__.py
│   └── mi_modelo.py       ← Clases ORM (campos, computed, constraints, onchange)
│
├── views/
│   └── mi_modelo_views.xml ← Definiciones de UI: tree, form, kanban, search, graph
│
├── security/
│   ├── ir.model.access.csv ← Permisos CRUD (crear, leer, actualizar, borrar)
│   └── security.xml        ← Grupos de usuarios y reglas de registro
│
├── data/
│   └── demo_data.xml       ← Datos de demostración / configuración inicial
│
├── static/
│   ├── src/js/             ← Componentes OWL y JavaScript
│   └── src/css/            ← Estilos SCSS/CSS
│
└── controllers/
    └── main.py             ← Endpoints HTTP / REST API
```

<div class="tip">

**🧠 Arquitectura modular:** Cada módulo puede depender de otros (`depends` en manifest). Esto permite componer funcionalidades como bloques de Lego. ¿Necesitás facturación? Agregás el módulo de contabilidad. ¿Ventas online? Agregás eCommerce.

</div>

<!--

Esta slide es importante porque es el ADN de Odoo. Todo es modular.

Cada módulo es una unidad independiente que puede:
- Definir modelos de datos (tablas en PostgreSQL)
- Definir vistas (cómo se ve en pantalla)
- Definir permisos (quién puede hacer qué)
- Definir datos iniciales (demo data)
- Depender de otros módulos

La estructura siempre es la misma. Si aprenden esta estructura,
pueden crear cualquier módulo de Odoo.

Fíjense los archivos clave:
- __manifest__.py: los metadatos del módulo
- models/: la lógica de negocio
- views/: la interfaz de usuario
- security/: los permisos y grupos

Esto es MVC en estado puro. Modelos en Python, vistas en XML,
controladores en Python.
-->
---

# 🔧 Herramientas del Desarrollador Odoo

<div class="columns">
<div>

| Herramienta | ¿Para qué sirve? |
|-------------|------------------|
| **`?debug=1`** | Activa el modo developer en la UI |
| **`odoo-bin scaffold`** | Genera el ESQUELETO de un módulo |
| **`odoo-bin shell`** | REPL interactivo con acceso al ORM |
| **OWL Devtools** | Extensión Chrome para debug OWL |
| **Odoo.sh** | CI/CD + hosting gestionado |
| **Runbot** | CI oficial — test por commit |
| **pgAdmin/DBeaver** | Admin de PostgreSQL |
| **VS Code + Python** | IDE recomendado |

</div>
<div>

### Comandos esenciales

```bash
# Scaffold — crear esqueleto de módulo
python odoo-bin scaffold mi_modulo /ruta/addons

# Shell — REPL con ORM
python odoo-bin shell -d mi_db

# Actualizar módulo
python odoo-bin -u mi_modulo --stop-after-init

# Instalar módulo
python odoo-bin -i mi_modulo --stop-after-init

# Modo debug en URL
http://localhost:8069/web?debug=1

# Activar modo developer
# Settings → Activate Developer Mode
```

### 📚 Documentación oficial

```
Odoo Docs 19.0 → docs.odoo.com/19.0
Developer Tutorial → docs.odoo.com/19.0/developer
OWL Framework → github.com/odoo/owl
Odoo GitHub → github.com/odoo/odoo
```

</div>
</div>

<!--

Estas son las herramientas que van a usar si desarrollan sobre Odoo.

La más importante es odoo-bin scaffold — genera todo el esqueleto
de un módulo en un comando. Después solos tienen que completar los
archivos.

El modo developer es clave: con ?debug=1 en la URL, acceden a menús
técnicos que muestran modelos, vistas, acciones, etc.

Odoo.sh es la plataforma de hosting de Odoo Enterprise pero si usan
Community, pueden hacer CI/CD con GitHub Actions también.

Y ojo: el shell de Odoo es poderosísimo. Es como Django shell —
podés importar modelos, hacer queries, probar métodos. Muy útil
para debuggear.
-->
---

# ✨ Novedades Odoo 18 (Oct 2024)

<div class="columns">
<div>

### IA y escalabilidad

- 🤖 **IA predictiva** en manufactura y análisis de ventas
- 🏭 **Starter packs por industria** — configuraciones pre-armadas para Bakery, Food Truck, Electrician, Cleaning Service, etc.
- 🚚 **Dispatch Management System** — logística con flota propia y 3PL
- 🔗 **Trazabilidad cross-company** de lotes y números de serie
- 📄 **OCR mejorado** para automatización de documentos (facturas, comprobantes)
- 💳 **Nuevo modelo de precios:** One App Free / Standard / Custom
- 🔌 **API pública** más estable para integraciones externas

</div>
<div>

### Impacto para desarrolladores

```
┌──────────────────────────────────────────────┐
│                                              │
│   Odoo 18 cambió el modelo de negocio:       │
│                                              │
│   • One App Free → 1 app gratis,            │
│     usuarios ilimitados                      │
│                                              │
│   • Standard → USD 24.90/usr/mes            │
│     todas las apps                           │
│                                              │
│   • Custom → multi-empresa, pricing         │
│     personalizado                            │
│                                              │
│   → Más accesible para startups             │
│   → Más fácil de "vender" internamente      │
│                                              │
└──────────────────────────────────────────────┘
```

</div>
</div>

<!--
Odoo 18 trajo un montón de novedades, pero la más importante para
el negocio: el cambio de modelo de precios.

Antes era por app y por usuario. Ahora: una app gratis, o todo
incluido por 24.90 USD por usuario. Esto hace que sea mucho más
fácil para una empresa decir "probemos Odoo".

Para desarrolladores, la API pública más estable es un game changer
— significa que integrar Odoo con otros sistemas es más predecible.
-->
---

# ✨ Novedades Odoo 19 (Sep 2025)

<div class="columns">
<div>

### AI-first, OWL completo

- 🦉 **OWL completo** — migración total del frontend a OWL. Adiós al JS legacy.
- 🧠 **IA generativa integrada:**
  - Generación de flujos de trabajo con lenguaje natural
  - Auto-completado de datos en formularios
  - Guía contextual en tiempo real
- 🛍️ **Integraciones eCommerce:** Google Merchant Center, Facebook Shop, TikTok Shop, Gelato (print-on-demand)
- 🌱 **Módulos ESG** — Environmental, Social, Governance — reporting de sostenibilidad
- 💳 **Odoo Expense Card** — tarjeta corporativa con sincronización automática
- 📱 **App móvil mejorada** — bottom-sheet navigation

</div>
<div>

### ¿Qué significa "AI-first"?

```
No es "agregamos IA a Odoo".
Es "rediseñamos Odoo para que la IA
sea parte del core".

Ejemplos concretos:
• El asistente te sugiere próximos pasos
• Autocompleta campos recurrentes
• Genera reportes en lenguaje natural
• Detecta anomalías en flujos de trabajo

→ IA como UX, no como feature
```

<div class="highlight">

**¿Por qué importa?** Porque marca la dirección del ERP: ya no es solo un sistema de registro, sino un **asistente activo** del negocio. Un ERP que te anticipa problemas en vez de solo registrar lo que pasó.

</div>

</div>
</div>

<!--

Odoo 19, lanzado en septiembre de 2025, fue un release enorme.

Lo más importante: la migración completa a OWL en frontend. Esto
significa que todo el JS legacy que venía de versiones anteriores
finalmente se fue. Más rápido, más mantenible, más moderno.

Pero el headline es "AI-first". Odoo está integrando IA generativa
en el core del producto. No como un feature aparte, sino como parte
de la experiencia de usuario. El sistema te sugiere qué hacer, te
autocompleta, te alerta.

Esto es importante para ustedes como futuros ingenieros: el ERP
del futuro no es pasivo — registra lo que pasó — sino activo —
te dice qué va a pasar y qué deberías hacer.

Los módulos ESG son otra tendencia: las empresas necesitan reportar
su impacto ambiental y social. Odoo está integrando eso nativamente.
-->
---

# 🧩 Desarrollo de Módulos Odoo — Paso a Paso

## De la idea al módulo instalado en 4 pasos

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ 1. IDEA  │ → │2. MODELO│ → │3. VISTAS│ → │4. INSTALAR│
│          │    │         │    │          │    │           │
│ ¿Qué     │    │ Clase   │    │ Tree     │    │ odoo -u  │
│ necesito │    │ Python  │    │ Form     │    │ módulo   │
│ modelar? │    │ ORM     │    │ Kanban   │    │          │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
```

### El pipeline completo

```bash
# 1. GENERAR ESQUELETO (scaffold)
python odoo-bin scaffold techfarma_sensor /mnt/extra-addons/

# 2. EDITAR MODELO (models/sensor.py)
#    → Definir campos, computed, constraints, onchange

# 3. EDITAR VISTAS (views/sensor_views.xml)
#    → Tree (lista), Form (detalle), Kanban (tarjetas)

# 4. CONFIGURAR SEGURIDAD (security/ir.model.access.csv)
#    → Quién puede leer, crear, editar, borrar

# 5. INSTALAR / ACTUALIZAR
docker exec odoo_workshop_app odoo -u techfarma_sensor --stop-after-init
docker restart odoo_workshop_app

# 6. VER RESULTADO EN UI
#    → Apps → TechFarma → Sensores IoT
```

<!--

Acá vamos a ver cómo se crea un módulo Odoo de principio a fin.
Son 4 pasos conceptuales: idea, modelo, vistas, instalar.

La herramienta clave: odoo-bin scaffold. Con un solo comando genera
todo el esqueleto del módulo con la estructura de directorios.

Después, el trabajo real es:
1. Definir el modelo de datos (Python + ORM)
2. Definir cómo se ve (XML - vistas)
3. Definir quién accede (CSV - permisos)

Y en el workshop, vamos a hacer esto EN VIVO. Van a verme crear
un módulo desde cero en menos de 3 minutos. Para que vean que NO
es complicado.
-->
---

# 📁 Anatomía de un Módulo — Código Comentado

## `__manifest__.py` — La cédula de identidad del módulo

```python
# -*- coding: utf-8 -*-
# ═════════════════════════════════════════════════════════
# MANIFEST — Todo módulo Odoo necesita uno
# Define: nombre, versión, dependencias, archivos a cargar
# ═════════════════════════════════════════════════════════
{
    # ── Identificación ─────────────────────────────────
    'name': "TechFarma Custom",

    # Versión semántica: ODOO.MAJOR.MINOR.PATCH
    # 19.0 = compatible con Odoo 19
    # 1.0.0 = primera release estable
    'version': '19.0.1.0.0',

    'summary': "Gestión de sensores IoT para TechFarma S.A.",
    'author': "Workshop Ingeniería en Sistemas",

    # ── Dependencias ───────────────────────────────────
    # Sin estas apps, el módulo no funciona
    'depends': [
        'base',               # ← SIEMPRE necesario (núcleo Odoo)
        'mail',               # ← Para chatter / notificaciones
        'product',            # ← Para enlazar sensores con productos
        'sale_management',    # ← Para integración con ventas
    ],

    # ── Archivos a cargar ──────────────────────────────
    # El ORDEN IMPORTA: security primero, después views, después data
    'data': [
        'security/ir.model.access.csv',    # Permisos CRUD
        'security/security.xml',            # Grupos de usuarios
        'views/sensor_views.xml',           # Interfaz de usuario
        'data/sensor_demo_data.xml',        # Datos demo
    ],

    'installable': True,    # Se puede instalar desde UI
    'application': True,    # Aparece como app independiente
    'license': 'LGPL-3',    # Misma licencia que Odoo Community
}
```

<!--
Este es el __manifest__.py — piensenlo como el package.json de
un módulo Odoo. Es lo primero que Odoo lee para entender qué hace
el módulo.

Puntos clave:
- 'depends': acá se declara de qué otros módulos depende. Si no
  ponen 'mail', no van a tener chatter. Si no ponen 'product',
  no pueden vincular a productos.
- El orden de 'data' importa: primero permisos (security), después
  vistas (views), después datos demo (data).
- 'application: True' hace que aparezca como app en el menú Apps.
-->
---

# 🐍 Modelo ORM (1/2) — Campos y Computed

```python
from odoo import models, fields, api
from datetime import date

class IoTSensor(models.Model):
    _name = 'techfarma.sensor'     # → se convierte en BD: techfarma_sensor
    _description = 'Sensor IoT de Campo'
    _inherit = ['mail.thread']     # → agrega chatter/historial
    _rec_name = 'name'

    # ── CAMPOS BÁSICOS ─────────────────────────────────
    name = fields.Char('N° Serie', required=True)  # ← obligatorio
    product_id = fields.Many2one(          # → FK a producto
        'product.product', 'Producto')
    partner_id = fields.Many2one(          # → FK a cliente
        'res.partner', 'Cliente')
    installation_date = fields.Date(       # ← default = hoy
        'Fecha Instalación', default=fields.Date.today)
    state = fields.Selection([             # → dropdown
        ('draft','Borrador'), ('active','Activo'),
        ('maintenance','Mantenimiento'), ('retired','Retirado')],
        default='draft')

    # ── CAMPO COMPUTADO ────────────────────────────────
    # Se recalcula SOLO cuando cambian sus dependencias
    days_active = fields.Integer(
        'Días Activo', compute='_compute_days_active')

    @api.depends('installation_date', 'state')
    def _compute_days_active(self):
        today = date.today()
        for r in self:
            if r.installation_date and r.state == 'active':
                r.days_active = (today - r.installation_date).days
            else:
                r.days_active = 0
```

<div class="feature-grid">
  <div class="feature-item">
    <strong>📋 Char</strong>
    Texto corto. `required=True` = campo obligatorio.
  </div>
  <div class="feature-item">
    <strong>🔗 Many2one</strong>
    Clave foránea. Referencia a otra tabla.
  </div>
  <div class="feature-item">
    <strong>📅 Date</strong>
    Fecha. `default=fields.Date.today` = hoy.
  </div>
  <div class="feature-item">
    <strong>🎯 Selection</strong>
    Dropdown fijo. Almacena string, muestra label.
  </div>
  <div class="feature-item">
    <strong>🧮 Computed</strong>
    Se calcula via método Python. `@api.depends` = triggers.
  </div>
  <div class="feature-item">
    <strong>🔄 mail.thread</strong>
    Chatter automático: crea historial de cambios.
  </div>
</div>

<!--
Este slide muestra la estructura básica de un modelo Odoo.

El 90% de un modelo Odoo son campos. Los tipos principales son:
Char, Many2one (FK), Date, Selection, Integer, Float, Text, Boolean.

El campo computed es lo más poderoso: se calcula automáticamente y
Odoo sabe cuándo recalcularlo gracias a @api.depends.

_inherit = ['mail.thread'] agrega el chatter — historial de cambios,
comentarios, adjuntos. Es como tener un log automático por registro.

Todo esto son 30 líneas de Python. Sin SQL, sin HTML. El ORM genera
la tabla, las vistas básicas, y el CRUD completo.
-->
---

# 🐍 Modelo ORM (2/2) — Constraints y Métodos de Negocio

```python
from odoo.exceptions import ValidationError

    # ── CONSTRAINT ─────────────────────────────────────
    # Se ejecuta ANTES de guardar. Si falla → rollback.
    @api.constrains('name')
    def _check_serial_format(self):
        for r in self:
            if r.name and not r.name.startswith('TF-'):
                raise ValidationError(
                    f"El N° de serie debe empezar con TF- "
                    f"(recibido: {r.name})")

    # ── MÉTODOS DE NEGOCIO ─────────────────────────────
    # Se llaman desde BOTONES en la UI (ver vistas XML)
    def action_activate(self):
        """Activar sensor."""
        for r in self:
            if r.state == 'draft':
                r.state = 'active'

    def action_send_to_maintenance(self):
        """Enviar a mantenimiento."""
        for r in self:
            if r.state == 'active':
                r.state = 'maintenance'

    def action_retire(self):
        """Retirar sensor definitivamente."""
        for r in self:
            if r.state in ('active', 'maintenance'):
                r.state = 'retired'
```

<div class="columns">
<div>

### ⚠️ Constraints
Validaciones a nivel ORM:

- `@api.constrains('campo')` se ejecuta al guardar
- Si levanta `ValidationError`, la BD no se modifica
- Sirve para: formato, rangos, unicidad, reglas de negocio
- Alternativa: `_sql_constraints` para checks a nivel BD

</div>
<div>

### 🎮 Métodos de Negocio
Lógica reutilizable desde cualquier lugar:

- Se definen como métodos de la clase
- Se exponen como **botones** en vistas form
- Se pueden llamar desde acciones de servidor
- Operan sobre `self` como recordset (uno o varios registros)
- El loop `for r in self:` es la norma

</div>
</div>

<!--
Las constraints son validaciones que corren antes de guardar.
Si un número de serie no empieza con TF-, la operación falla.
Esto es mejor que validar solo en el frontend porque la
validación corre del lado del servidor, siempre.

Los métodos de negocio son funciones que operan sobre registros.
Se pueden llamar desde botones en la UI, desde acciones
automatizadas, o desde código. El patrón es siempre el mismo:
iterar sobre self y modificar campos.

Fíjense que estos métodos no devuelven nada — simplemente
modifican el estado del registro. Odoo guarda automáticamente.
-->
---

# 🖼️ Vistas XML — Las 3 Caras del Modelo

<div class="columns">
<div>

### 📋 Vista Tree (lista)

```xml
<tree decoration-danger="is_overdue">
  <field name="name" string="N° Serie"/>
  <field name="product_id"/>
  <field name="state" widget="badge"/>
</tree>
```

- Muestra **varios registros** en grilla
- `decoration-danger` = fila roja si vencido
- `widget="badge"` → estado como etiqueta de color

### 📑 Vista Form (detalle)

```xml
<form>
  <header>
    <field name="state" widget="statusbar"/>
    <button name="action_activate" type="object"
            string="Activar" states="draft"/>
  </header>
  <sheet>
    <h1><field name="name"/></h1>
    <group>
      <field name="product_id"/>
      <field name="partner_id"/>
    </group>
  </sheet>
</form>
```

- Muestra **UN** registro completo
- `statusbar` → barra de progreso del estado
- `button states="draft"` → visible solo en ese estado

</div>
<div>

### 🃏 Vista Kanban (tarjetas)

```xml
<kanban>
  <field name="name"/>
  <field name="state"/>
  <templates>
    <t t-name="kanban-box">
      <div class="oe_kanban_card">
        <strong><field name="name"/></strong>
        <field name="state" widget="badge"/>
      </div>
    </t>
  </templates>
</kanban>
```

- Estilo **Trello** para visual management
- Ideal para pipelines (CRM, proyectos)
- Templates QWeb personalizables

</div>
</div>

### 🔌 ¿Cómo se conecta todo? — La Acción de Ventana

```xml
<!-- El puente entre modelo, vistas y menú -->
<record id="action_techfarma_sensor" model="ir.actions.act_window">
    <field name="name">Sensores IoT</field>
    <field name="res_model">techfarma.sensor</field>
    <field name="view_mode">kanban,tree,form</field>
</record>

<menuitem name="Sensores IoT"
          parent="menu_techfarma_root"
          action="action_techfarma_sensor"/>
```

<div class="tip">

**💡 Flujo completo:** Menú → Acción → Modelo + Vistas. Sin la acción, el modelo no aparece en la UI. Sin el menú, no se puede navegar hasta él.

</div>

<!--

Las vistas XML son la UI de Odoo. Tres tipos principales:

1. TREE — la grilla. Muestra muchos registros. Ideal para
   listados con filtros y búsqueda.

2. FORM — el detalle. Muestra un registro con todos sus
   campos, botones, pestañas. Ahí se hace el trabajo pesado.

3. KANBAN — tarjetas visuales. Para pipelines, flujos de
   trabajo, gestión visual.

Cada vista tiene un XML ID único. La acción de ventana las
vincula: "cuando el usuario hace click en este menú, mostrale
el modelo X con las vistas Y".

El widget en los campos cambia cómo se renderizan. badge =
etiqueta de color. statusbar = barra de progreso. Hay decenas
de widgets.
-->
---

# 🔐 Seguridad — Permisos CRUD

Los permisos se definen en `security/ir.model.access.csv`. Cada línea = un permiso.

| Columna | Significado |
|---------|-------------|
| `id` | Identificador único del permiso |
| `name` | Nombre descriptivo |
| `model_id:id` | Modelo (ej: `model_techfarma_sensor`) |
| `group_id:id` | Grupo que recibe el permiso |
| `perm_read` | 1 = puede LEER |
| `perm_write` | 1 = puede EDITAR |
| `perm_create` | 1 = puede CREAR |
| `perm_unlink` | 1 = puede BORRAR |

```csv
id,name,model_id:id,group_id:id,read,write,create,delete
sensor_user,user,model_techfarma_sensor,group_user,1,1,1,0
sensor_mgr,manager,model_techfarma_sensor,group_mgr,1,1,1,1
```

<div class="columns">
<div>

### 👤 Usuario

- Lee: ✅
- Edita: ✅
- Crea: ✅
- Borra: ❌

`perm_unlink = 0` → no puede eliminar

</div>
<div>

### 👑 Manager

- Lee: ✅
- Edita: ✅
- Crea: ✅
- Borra: ✅

`perm_unlink = 1` → acceso completo

</div>
</div>

<div class="tip">

**💡 Regla de oro:** Nunca dar `perm_unlink=1` a usuarios comunes. Solo managers. Esto previene borrados accidentales.

</div>

<!--

La seguridad en Odoo se maneja con un archivo CSV. Simple y efectivo.

Cada línea es un permiso que le dice a Odoo: "El grupo X tiene permiso
para hacer Y sobre el modelo Z".

Los permisos son CRUD: Create, Read, Update, Delete. Es decir:
- perm_read = 1 → puede ver registros
- perm_write = 1 → puede editar
- perm_create = 1 → puede crear nuevos
- perm_unlink = 1 → puede borrar

Nunca, NUNCA, le den permiso de borrado a usuarios comunes. Que solo
los managers puedan borrar. Lo aprendemos con sangre en producción.

Además de este CSV, podemos definir grupos de usuarios (security.xml)
y reglas de registro (record rules) para filtrar qué registros ve cada
usuario. Por ejemplo: "cada vendedor solo ve sus propios leads".
-->
---

# 💰 Monetización — Cómo ganar plata con Odoo

## Odoo no es solo un ERP: es un ECOSISTEMA de negocio

<div class="columns-3">
<div>

### 🏪 1. Odoo App Store

**Vender módulos en la tienda oficial**

- **Modelo:** venta directa de módulos
- **Precios:** desde USD 5 hasta USD 500+
- **Comisión:** Odoo se queda ~30%
- **Requisitos:** Odoo Partner o cuenta de desarrollador
- **Ejemplos:** módulos de localización argentina, integraciones con Mercado Pago, AFIP, factura electrónica

<div class="highlight">

💰 **Ejemplo real:** Módulo de factura electrónica AFIP para Argentina — se vende a USD 150-300 por cliente.

</div>

</div>
<div>

### 🤝 2. Odoo Partner

**Implementación y consultoría**

- **Niveles:** Silver, Gold, Platinum
- **Facturación:** USD 50-150/hora
- **Servicios:**
  - Implementación (2-6 meses)
  - Customización de módulos
  - Migración desde otros ERPs
  - Capacitación y soporte
- **Requisitos:** certificación técnica y funcional

<div class="tip">

💡 **Partner Silver:** desde 1 certificación. Ideal para empezar.

</div>

</div>
<div>

### 🔧 3. Freelance / PyME

**Desarrollo a medida**

- **Perfil:** desarrollador Python freelance
- **Tarifas:** USD 30-80/hora
- **Proyectos típicos:**
  - Módulos de integración (API REST)
  - Localización contable (impuestos, reportes)
  - Personalización de flujos
  - Soporte técnico
- **Plataformas:** Upwork, Freelancer, LinkedIn, comunidad Odoo

<div class="warning">

⚠️ **A tener en cuenta:** Odoo mueve +44.000 módulos en su tienda. Hay competencia. La clave está en encontrar un nicho.

</div>

</div>
</div>

<!--

Y ahora, la pregunta del millón: ¿cómo se gana plata con Odoo?

Tres caminos principales:

1. Odoo App Store: creás un módulo, lo subís a la tienda, y
   cada vez que alguien lo compra, ganás plata. Ejemplo concreto:
   la localización argentina — IVA, ingresos brutos, factura
   electrónica AFIP — es un módulo que se vende bien porque
   toda empresa argentina que usa Odoo lo necesita.

2. Ser partner de Odoo: implementás Odoo en empresas. Esto va
   desde configurar el sistema hasta desarrollar módulos a medida.
   Los partners facturan USD 50-150 por hora.

3. Freelance: muchas PyMEs necesitan customizaciones chicas y
   no pueden pagar un partner. Ahí entran los desarrolladores
   freelance.

El truco está en el nicho: si saben de contabilidad argentina
y Odoo, tienen un diferenciador enorme. Si saben de logística
y Odoo, igual. No compitan en precio, compitan en expertise.
-->
---

# 📦 Publicar en Odoo App Store — El Camino

**El pipeline para llevar tu módulo al mercado:**

<div class="flow">
  <span>🧪 1. Desarrollar</span>
  <span class="arrow">→</span>
  <span>📸 2. Preparar</span>
  <span class="arrow">→</span>
  <span>🚀 3. Subir</span>
  <span class="arrow">→</span>
  <span>🔧 4. Mantener</span>
</div>

Código probado + Screenshots + Descripción + Precio → **Odoo App Store**

<div class="columns">
<div>

### 📊 Datos del mercado

| Indicador | Valor |
|-----------|-------|
| Apps en la tienda | 44.000+ |
| Descargas top 10% | 1.000+ / mes |
| Precio promedio | USD 45 |
| Ingreso anual top devs | USD 10K - 50K+ |
| Categorías + rentables | Contabilidad, RRHH, Localización |

### 💰 Ejemplo concreto: Argentina

**Factura electrónica AFIP + IVA + IIBB**
- Precio: **USD 150-300** por instalación
- Clientes potenciales: **miles de PyMEs** argentinas
- Diferenciador: conocés la legislación local

</div>
<div>

### 🔑 5 claves del éxito

<div class="feature-grid">
  <div class="feature-item">
    <strong>🎯 1. Problema real</strong>
    No crees "otro módulo de weather". Resolvé un dolor concreto.
  </div>
  <div class="feature-item">
    <strong>🌎 2. Localización</strong>
    Contabilidad argentina/chilena/peruana = nicho asegurado.
  </div>
  <div class="feature-item">
    <strong>⚡ 3. Soporte rápido</strong>
    La reputación en la tienda es tu activo más valioso.
  </div>
  <div class="feature-item">
    <strong>🔄 4. Actualizá</strong>
    Cada release de Odoo puede romper tu módulo. Mantenelo al día.
  </div>
  <div class="feature-item">
    <strong>🏷️ 5. Versionado</strong>
    Usá semver: `19.0.1.0.0` = compatible con Odoo 19.
  </div>
</div>

### 📝 Requisitos para publicar

| Requisito | Detalle |
|-----------|---------|
| Cuenta | Partner Odoo o desarrollador |
| Comisión | ~30% para Odoo |
| Revisión | Control de calidad manual |
| Idioma | Mínimo inglés en descripción |

</div>
</div>

<!--

Para publicar en la App Store, el proceso es bastante directo:

1. Desarrollás el módulo (lo que acabamos de ver)
2. Preparás screenshots, descripción, precio
3. Te registrás como desarrollador (o partner)
4. Odoo revisa la calidad y lo publica

¿Cuánto se puede ganar? Depende del módulo. Los módulos de
localización (impuestos de cada país, facturación electrónica)
son los que mejor rinden porque son NECESARIOS y específicos
de cada región.

En Argentina, un módulo de factura electrónica AFIP bien hecho
puede venderse a USD 200-500 por instalación. Y hay miles de
PyMEs argentinas que usan o van a usar Odoo.

El secreto: encontrá un nicho, hacelo bien, y mantenelo.
-->
---

# 🔧 Odoo + OCA — El Ecosistema Open Source

> **OCA (Odoo Community Association):** La comunidad global de desarrolladores Odoo. Más de 1.000 módulos open-source adicionales.

<div class="columns">
<div>

### ¿Qué es OCA?

- Asociación sin fines de lucro
- Módulos open-source (LGPL) que complementan Odoo
- +1.000 módulos mantenidos por la comunidad
- Estándares de calidad rigurosos (revisión de código obligatoria)
- **Gratuito** — cualquiera puede contribuir

### Proyectos destacados de OCA

| Proyecto | Descripción |
|----------|-------------|
| **OCA/account** | Localización contable multi-país |
| **OCA/stock** | Extensiones de inventario |
| **OCA/web** | Widgets y herramientas web |
| **OCA/reporting** | Reportes avanzados |

</div>
<div>

### ¿Por qué importa?

```
┌──────────────────────────────────────────────┐
│                                              │
│  Odoo base te da el 80% de la funcionalidad. │
│  OCA te da el 15% extra que necesitás.       │
│  El 5% restante lo desarrollás vos.          │
│                                              │
│  → Estrategia:                               │
│    1. Buscá en OCA si existe                 │
│    2. Si existe, usalo o contribuí           │
│    3. Si no existe, desarrollalo             │
│    4. Si funcionó, contribuilo a OCA         │
│                                              │
└──────────────────────────────────────────────┘
```

### Cómo contribuir

```
1. Fork del repositorio (github.com/OCA/<repo>)
2. Crear un módulo siguiendo estándares OCA
3. Abrir un PR con revisión de código
4. Pasar tests automatizados (Runbot)
5. Merge → sale en la próxima release
```

</div>
</div>

<!--

La OCA es la comunidad detrás de Odoo. Es como la Fundación Linux
para Linux, o la Apache Foundation para Apache.

Tienen más de 1.000 módulos open-source que complementan Odoo.
Localizaciones, extensiones, herramientas. Y todo es gratuito.

La estrategia inteligente como desarrollador Odoo:
1. Antes de escribir una línea de código, busquen en OCA
2. Si ya existe, úsenlo o mejórenlo
3. Si no existe, créenlo y contribúyanlo

Contribuir a OCA es:
- Bueno para su portfolio
- Bueno para la comunidad
- Bueno para conseguir clientes (los clientes buscan devs que
  contribuyen a OCA)
- Les da estándares de calidad

Y ojo: contribuir a OCA no es solo código. También necesitan
traductores, testers, documentadores.
-->
---

# 🏢 Empresa Simulada: TechFarma S.A.

> **Startup agroindustrial argentina** que produce y vende sensores IoT para agricultura de precisión, kits de análisis de suelo, software de monitoreo SaaS y servicios de consultoría. Opera en LATAM.

<div class="columns">
<div>

### 📦 Productos

| Tipo | Producto | Precio |
|------|----------|--------|
| 🔬 Hardware | Sensor IoT Suelo Pro | USD 299 |
| 🔬 Hardware | Estación Meteorológica | USD 599 |
| 🔬 Hardware | Gateway LoRa 4G | USD 449 |
| 📡 Hardware | Kit Sensor Completo | USD 899 |
| 💻 Software | TechFarma Cloud Anual | USD 1.200 |
| 🛠️ Servicio | Consultoría IoT | USD 1.500 |

</div>
<div>

### 🎭 Tu misión hoy

**Operás como parte del equipo de TechFarma S.A.** Tenés que ejecutar los flujos de tu departamento en **Odoo real**.

```
🔐 URL:  http://odoo.workshop.local
👤 User: g{grupo}_{nombre} (ej: g1_ana)
🔑 Pass: TechFarma2026!
🕐 Tiempo: 25 minutos de práctica
```

### 🔄 Flujo transversal del negocio

<div class="flow">
  <span>Proveedor</span>
  <span class="arrow">→</span>
  <span>Compra</span>
  <span class="arrow">→</span>
  <span>Stock</span>
  <span class="arrow">→</span>
  <span>Manufactura</span>
  <span class="arrow">→</span>
  <span>Venta</span>
  <span class="arrow">→</span>
  <span>Factura</span>
</div>

</div>
</div>

<!--

Presentación de TechFarma S.A. — la empresa donde hoy todos trabajan.

La empresa tiene productos concretos: sensores IoT, software cloud,
servicios de consultoría. Esto es importante porque cuando hacen
una venta o una compra, van a ver productos reales con precios reales.

El flujo transversal es la magia del ERP: un proveedor nos vende
componentes → los recibimos en stock → los transformamos en
productos terminados → los vendemos → facturamos al cliente.

Cada grupo es un eslabón de esta cadena.
-->
---

# 🎭 Grupos y Roles — 5 Departamentos

| Grupo | Departamento | Integrantes | Flujo Principal | Indicador de Éxito |
|-------|-------------|-------------|-----------------|-------------------|
| **G1** 🛒 | **Ventas & CRM** | 8 estudiantes | Lead → Oportunidad → Presupuesto → OV | Cerrar 2 ventas + USD 15K |
| **G2** 📦 | **Supply Chain** | 8 estudiantes | OC → Recepción → Stock → Reabastecimiento | 1 OC completa + regla de reabastecimiento |
| **G3** 🏭 | **Manufactura** | 8 estudiantes | BoM → OP → Producción → Calidad | 10 kits producidos |
| **G4** 💰 | **Contabilidad** | 8 estudiantes | Factura → Pago → Conciliación → Reportes | 1 factura + P&L generado |
| **G5** 👥 | **RRHH & TI** | 8 estudiantes | Empleado → Proyecto → Tareas → Portal | Alta empleado + proyecto con tareas |

<div class="highlight">

**💡 El flujo completo de TechFarma:**
Proveedor → **G2 Compra** → **G2/G3 Stock** → **G3 Manufactura** → **G1 Venta** → **G4 Factura**

**Cada grupo depende del trabajo del grupo anterior.** ¡Si no compran los componentes, no hay producción! ¡Si no producen, no hay venta!

</div>

<!--

Esta es la distribución de los 40 estudiantes en 5 grupos de 8.

Cada grupo representa un departamento de TechFarma con actividades
concretas para hacer en los 25 minutos de práctica.

Importante: los grupos trabajan EN PARALELO al mismo tiempo.
Cada grupo en su módulo. El orador va rotando para ayudar.

El indicador de éxito es simple — cada grupo tiene una meta
clara: G1 tiene que cerrar 2 ventas, G3 tiene que producir 10
kits, etc.

La magia ocurre cuando se dan cuenta de que el flujo es
transversal: G2 compra los componentes, G3 los transforma,
G1 vende el producto terminado, G4 factura. Esa integración
es el valor del ERP.
-->
---

# 🛒 G1 — Ventas & CRM

**Rol:** Equipo comercial de TechFarma
**Objetivo:** Cerrar **2 ventas** por un total de **USD 15.000+**

<div class="columns">
<div>

### 📋 Paso a paso

**A — Pipeline de ventas (10 min)**
1. Ir a **CRM → Leads/Oportunidades**
2. Crear 3 leads desde distintas fuentes
3. Mover por el pipeline Kanban: Nuevo → Calificado → Propuesta → Ganado
4. Registrar una llamada en el chatter
5. Marcar oportunidad como "Ganada"

**B — Presupuesto y OV (8 min)**
1. Crear **presupuesto** desde la oportunidad ganada
2. Agregar: 5x Sensor IoT Suelo Pro + 1x Consultoría
3. Aplicar 10% de descuento
4. Confirmar la orden de venta

**C — Dashboard (2 min)**
1. **Reportes → Análisis de Ventas**
2. Agrupar por vendedor y mes

</div>
<div>

### ✅ Checklist del equipo

- [ ] 3 leads creados
- [ ] 1 oportunidad marcada como "Ganada"
- [ ] Presupuesto enviado
- [ ] Orden de venta confirmada
- [ ] Factura generada automáticamente
- [ ] Dashboard de ventas consultado

<div class="tip">

**💡 Observá:** cuando confirmás la orden de venta, Odoo genera automáticamente:
- Un albarán de entrega en Inventario
- La factura pendiente en Contabilidad

🔗 **Integración automática** — no hay que copiar datos de un lado a otro.

</div>

</div>
</div>

<!--

Para el grupo de Ventas: el objetivo es simple, tienen que vender.
Creen leads, muévanlos por el pipeline, y cierren la venta.

El momento mágico es cuando confirman la orden de venta y ven
que Odoo automáticamente:
1. Crea un albarán de entrega (lo ve G2/G3)
2. Crea una factura pendiente (lo ve G4)

Esa es la demostración más clara del valor de un ERP: integración
transversal sin intervención manual.
-->
---

# 📦 G2 — Supply Chain

**Rol:** Equipo de supply chain de TechFarma
**Objetivo:** Gestionar el abastecimiento y el stock de la empresa

<div class="columns">
<div>

### 📋 Paso a paso

**A — Orden de compra (8 min)**
1. Ir a **Compras → Órdenes de Compra**
2. Crear OC para "Microcontroladores ESP32" a "ElectroComp S.A."
3. 200 unidades a USD 12 c/u
4. Confirmar la OC
5. Registrar la **recepción del material**
6. Verificar stock en **Inventario → Productos**

**B — Gestión de almacén (10 min)**
1. Crear regla de **reabastecimiento** (mínimo 50 Sensores IoT)
2. Ejecutar scheduler → ver OC generada automáticamente
3. Realizar **ajuste de inventario**
4. Transferencia interna entre ubicaciones
5. Ver **informe de trazabilidad**

**C — Análisis (2 min)**
1. Reportes → Análisis de compras

</div>
<div>

### ✅ Checklist del equipo

- [ ] OC creada y confirmada
- [ ] Recepción de material registrada
- [ ] Movimiento de stock verificado
- [ ] Regla de reabastecimiento configurada
- [ ] Ajuste de inventario realizado
- [ ] Trazabilidad consultada

<div class="tip">

**💡 Observá la trazabilidad:** si los productos tienen número de lote o serie, Odoo te permite trackear el recorrido completo desde que entran como compra hasta que salen como venta.

</div>

<div class="warning">

⚠️ **Sin compras no hay producción.** G3 depende de que G2 reciba los componentes a tiempo. ¡Coordinación!

</div>

</div>
</div>

<!--

Supply Chain: son los que compran los materiales y gestionan el stock.

La orden de compra es el punto de entrada de materiales al sistema.
Cuando la confirman, Odoo actualiza automáticamente el stock
"esperado".

Cuando registran la recepción, el stock físico se actualiza.

La regla de reabastecimiento es genial: pueden configurar "cuando
el stock de X baje de 50 unidades, generar automáticamente una
orden de compra". Odoo lo hace solo.
-->
---

# 🏭 G3 — Manufactura

**Rol:** Equipo de producción de TechFarma
**Objetivo:** Producir **10 kits completos** "Sensor IoT Completo"

<div class="columns">
<div>

### 📋 Paso a paso

**A — Lista de materiales (8 min)**
1. Ir a **Manufactura → Listas de Materiales (BoM)**
2. Revisar BoM existente: "Kit Sensor IoT Completo"
3. Agregar "Carcasa Plástica ABS" como componente
4. Crear **Orden de Producción** para 10 kits
5. Confirmar y ejecutar la producción
6. Validar → ver ingreso al inventario

**B — Centro de trabajo (8 min)**
1. Configurar **Centro de Trabajo** (estación de ensamblaje)
2. Agregar operación "Ensamblaje" — 30 min/unidad
3. Registrar tiempo trabajado
4. Comparar **costo real vs. estimado**

**C — Reporte (4 min)**
1. Reportes → Análisis de manufactura
2. Ver eficiencia por orden

</div>
<div>

### ✅ Checklist del equipo

- [ ] BoM revisada y modificada
- [ ] Orden de producción creada
- [ ] Componentes consumidos
- [ ] Productos ingresados al inventario
- [ ] Centro de trabajo configurado
- [ ] Costo real vs. estimado comparado

<div class="tip">

**💡 La lista de materiales (BoM)** es la "receta" del producto. Define qué componentes se necesitan y en qué cantidades para producir una unidad.

Odoo calcula automáticamente el costo de producción en base a los costos de los componentes + tiempo de trabajo.

</div>

<div class="warning">

⚠️ **Sin stock no hay producción.** Si G2 no compró los componentes, G3 no puede producir. La producción depende de que el inventario tenga los materiales.

</div>

</div>
</div>

<!--

Manufactura produce el producto terminado a partir de los componentes
que G2 compró.

La Lista de Materiales (BoM o Bill of Materials) es la receta:
para hacer 1 Kit Sensor IoT Completo necesitás X sensores,
Y carcasas, Z microcontroladores.

Cuando ejecutan la orden de producción, Odoo:
1. Consume los componentes del stock
2. Produce el producto terminado
3. Lo ingresa al inventario automáticamente
4. Calcula el costo real de producción

La comparación costo real vs. estimado es clave para saber si
la operación es rentable.
-->
---

# 💰 G4 — Contabilidad

**Rol:** Equipo financiero de TechFarma
**Objetivo:** Facturar operaciones y conciliar pagos

<div class="columns">
<div>

### 📋 Paso a paso

**A — Facturación (8 min)**
1. Ir a **Contabilidad → Clientes → Facturas**
2. Crear factura manual para un cliente
3. Agregar líneas con IVA 21% (Argentina)
4. Validar y confirmar la factura
5. Registrar el **pago** contra la factura
6. Ver la **conciliación bancaria** automática

**B — Reportes contables (8 min)**
1. Explorar el **Plan de Cuentas** argentino
2. Ver el **Libro Mayor** de la cuenta "Ventas"
3. Generar **Balance de sumas y saldos**
4. Ver **Informe de rentabilidad** (P&L)
5. Explorar flujo de caja

**C — Conciliación bancaria (4 min)**
1. Importar extracto bancario CSV
2. Ejecutar conciliación automática
3. Resolver diferencia manual

</div>
<div>

### ✅ Checklist del equipo

- [ ] Factura con IVA 21% creada
- [ ] Factura validada y confirmada
- [ ] Pago registrado
- [ ] Conciliación bancaria ejecutada
- [ ] Plan de cuentas explorado
- [ ] Balance de sumas y saldos generado

<div class="tip">

**💡 Odoo Contabilidad Community** incluye:
- Plan de cuentas multi-país
- IVA (general, reducido, adicional)
- Conciliación bancaria automática
- Libro Mayor y balance
- Reportes P&L y flujo de caja

Para Argentina, hay módulos OCA que agregan:
percepciones de IIBB, retenciones, y factura electrónica AFIP.

</div>

</div>
</div>

<!--

Contabilidad es donde termina el flujo del dinero.

Cuando G1 confirma una venta, Odoo ya creó la factura pendiente.
G4 solo tiene que validarla y registrar el pago.

La contabilidad argentina está configurada: IVA 21%, plan de
cuentas local. Pueden explorar el balance y el P&L.

La conciliación bancaria es automática: si cargan un extracto
bancario, Odoo matchea los pagos automáticamente.

En Odoo Community, la contabilidad es funcional pero básica.
Para más features (retenciones, percepciones, factura electrónica),
hay módulos OCA o de la App Store.
-->
---

# 👥 G5 — RRHH & TI

**Rol:** Equipo de recursos humanos y administración de TechFarma
**Objetivo:** Gestionar el equipo y los proyectos internos

<div class="columns">
<div>

### 📋 Paso a paso

**A — Alta de empleados (8 min)**
1. Ir a **Empleados → Nuevo Empleado**
2. Crear empleado completo: datos, contrato, departamento
3. Asignar a departamento (crear si no existe)
4. Configurar gestor directo
5. Crear **solicitud de tiempo libre** (vacaciones)

**B — Proyectos internos (10 min)**
1. **Proyecto → Nuevo:** "Implementación CRM 2025"
2. Crear tareas: Planning, Desarrollo, Testing, Go-Live
3. Asignar responsables y fechas
4. Mover tareas por el Kanban
5. Registrar **horas trabajadas**

**C — Portal de empleado (2 min)**
1. Acceder al **Portal de empleado**
2. Ver licencias, contratos, recibos

</div>
<div>

### ✅ Checklist del equipo

- [ ] Empleado creado con contrato
- [ ] Departamento asignado
- [ ] Estructura jerárquica configurada
- [ ] Solicitud de tiempo libre creada
- [ ] Proyecto con tareas y responsables
- [ ] Horas registradas

<div class="tip">

**💡 El módulo de RRHH en Community** incluye:
- Ficha de empleados con datos personales y laborales
- Departamentos y jerarquía
- Solicitudes de tiempo libre (vacaciones, licencias)
- Portal de autogestión para empleados

Para nómina (cálculo de sueldos y recibos) → **Enterprise**.

</div>

<div class="warning">

⚠️ En RRHH, los datos son sensibles. Odoo maneja permisos por rol: un empleado ve su propia ficha, RRHH ve todas.

</div>

</div>
</div>

<!--

RRHH y TI comparten grupo porque en una PyME suelen ser el mismo
equipo o trabajar muy cercanos.

En RRHH: dan de alta empleados, configuran la estructura de la
empresa, y gestionan proyectos internos.

El portal de empleado es interesante: cada empleado puede ver
sus propios datos, pedir vacaciones, ver sus recibos. Sin
necesidad de molestar a RRHH.

Importante: nómina (cálculo de sueldos) solo está en Enterprise.
En Community gestionan empleados y proyectos.
-->
---

# 🎯 Live Coding — Tu Primer Módulo Odoo

## 3 minutos. 3 pasos. Un módulo funcional.

<div class="columns">
<div>

### 🔴 Paso 1 — Scaffold

```bash
# Generar esqueleto del módulo
docker exec -it odoo_workshop_app bash -c "
  python /usr/lib/python3/dist-packages/odoo/odoo-bin \
  scaffold techfarma_custom /mnt/extra-addons/"
```

### 🔴 Paso 2 — Modelo mínimo

```python
# models/sensor.py — ≈ 30 líneas
from odoo import models, fields

class IoTSensor(models.Model):
    _name = 'techfarma.sensor'
    _description = 'Sensor IoT de Campo'

    name = fields.Char('N° Serie', required=True)
    product_id = fields.Many2one(
        'product.product', 'Producto')
    state = fields.Selection([
        ('draft', 'Borrador'),
        ('active', 'Activo'),
    ], default='draft')
```

### 🔴 Paso 3 — Instalar

```bash
# Actualizar módulos y reiniciar
docker exec odoo_workshop_app odoo \
  -c /etc/odoo/odoo.conf \
  -u techfarma_custom --stop-after-init

docker restart odoo_workshop_app
```

</div>
<div>

### 🔍 ¿Qué pasó?

En menos de **3 minutos**:

```
┌────────────────────────────────────────────┐
│                                            │
│  1. Scaffold → creó la estructura          │
│     de directorios del módulo              │
│                                            │
│  2. Modelo → definió una tabla nueva       │
│     en PostgreSQL con 3 campos             │
│                                            │
│  3. Instaló → Odoo cargó el módulo         │
│     y creó la tabla en la BD               │
│                                            │
│  → Resultado: el modelo es visible         │
│    en la UI (Configuración → Técnico)      │
│                                            │
└────────────────────────────────────────────┘
```

<div class="highlight">

**🧠 La magia de Odoo:** con 30 líneas de Python, un modelo es funcional: CRUD automático, búsqueda, vistas básicas. Sin escribir SQL. Sin controllers. Sin formularios HTML.

</div>

<div class="tip">

🔗 **Probalo después:** en la URL de tu Odoo, andá a Apps → `techfarma_custom` → Instalar. Después explorá el modelo en Configuración → Técnico → Modelos.

</div>

</div>
</div>

<!--

Y acá viene la magia: en 3 minutos, 3 pasos, creamos un módulo
funcional.

Paso 1: scaffold genera todo el esqueleto. No empezamos de cero.
Paso 2: un modelo con 30 líneas de Python. 3 campos nomás.
Paso 3: instalamos y ya está.

¿Lo mejor? No escribimos SQL. No escribimos HTML. No escribimos
controllers. Odoo genera todo automáticamente.

Este es el mensaje que quiero que se lleven: desarrollar sobre
Odoo NO es difícil. Si saben Python, ya saben el 80%.

Después del workshop, si quieren, les paso los links para seguir
aprendiendo. Pero el objetivo de hoy es que vean que es posible.
-->
---

# 📚 Recursos para Seguir Aprendiendo

<div class="columns">
<div>

### 📖 Documentación oficial

| Recurso | Link |
|---------|------|
| Odoo Docs 19.0 | docs.odoo.com/19.0 |
| Developer Tutorial | docs.odoo.com/19.0/developer |
| OWL Framework | github.com/odoo/owl |
| Odoo GitHub | github.com/odoo/odoo |
| Odoo eLearning | odoo.com/slides |

### 🎓 Cursos

- Odoo eLearning (oficial, **gratuito**)
- Udemy: "Odoo 18/19 Development"
- YouTube: **OCA Channel**
- Packt Publishing: *Odoo Development Essentials*

</div>
<div>

### 🤝 Comunidad

| Recurso | Link |
|---------|------|
| OCA (Odoo Community Association) | odoo-community.org |
| Odoo Forum | odoo.com/forum |
| Stack Overflow | #odoo |
| Reddit | r/Odoo |
| Telegram | Grupos locales Odoo AR |

### 💼 Para trabajar

- **Odoo Jobs** — jobs.odoo.com
- **Odoo Partner Directory** — partners.odoo.com
- **Upwork / Freelancer** — búsqueda "Odoo developer"
- **LinkedIn** — certificación Odoo en perfil
- **OCA GitHub** — contribuir a proyectos open-source

### 🏆 Certificaciones

- Odoo Functional Certification
- Odoo Technical Certification
- Odoo Sales Certification

</div>
</div>

<!--

Estos son los recursos para que sigan aprendiendo después del workshop.

Lo más importante: la documentación oficial de Odoo es excelente.
Tiene tutoriales, guías de desarrollo, y referencias de API.

La OCA es el segundo lugar más importante. Si se topan con un
problema, probablemente alguien de la comunidad ya lo resolvió.

Para trabajo: el mercado de desarrolladores Odoo está creciendo
mucho. Las certificaciones de Odoo tienen buena demanda.

Y si quieren contribuir a open-source, OCA tiene +1.000 repos
con issues etiquetados para principiantes.
-->
---

# 🎯 Preguntas de Reflexión Final

<div class="highlight" style="margin-bottom: 20px;">

**🌟 Para pensar mientras cerramos el workshop:**
</div>

<div class="columns">
<div>

### 💭 Sobre ERPs

**1.** ¿Qué diferencia hay entre usar módulos aislados (CRM + Excel + Contabilidad) vs. un ERP integrado? ¿En qué situaciones cada uno?

**2.** ¿Cómo impacta el open-source en las decisiones de arquitectura de software empresarial? ¿Ventajas y desventajas?

**3.** ¿En qué escenario elegirías **Odoo Community** vs **SAP S/4HANA**? ¿Y viceversa?

</div>
<div>

### 💭 Sobre el desarrollo

**4.** ¿Cómo extenderías Odoo para soportar el dominio específico de TechFarma (sensores IoT con telemetría en tiempo real)?

**5.** ¿Qué módulo de Odoo App Store te gustaría desarrollar para Argentina? ¿Qué problema resolvería?

**6.** ¿Cómo harías para integrar Odoo con otros sistemas? ¿API REST? ¿Webhooks? ¿ETL?

</div>
</div>

<br>

<div class="flow">
  <span>¿Preguntas?</span>
  <span class="arrow">→</span>
  <span>¿Comentarios?</span>
  <span class="arrow">→</span>
  <span>¿Ideas?</span>
</div>

<!--

Estas son preguntas para cerrar y pensar. No espero que las
respondan ahora — pero si alguna les queda dando vueltas, genial.

Las primeras tres son conceptuales: entender cuándo usar un ERP,
cómo el open-source cambia las reglas del juego, y cuándo elegir
Odoo vs. SAP.

Las últimas tres son más técnicas y proyectivas: cómo modelarían
el dominio de IoT, qué módulo harían para Argentina, cómo
integrarían Odoo con otros sistemas.

Si alguien quiere compartir su idea, bienvenido. Si no, que
queden como disparadores para pensar.
-->
---

<!-- _class: lead -->

# 🚀 ¡Gracias!

## Workshop: Odoo ERP para Ingeniería en Sistemas

**Emanuel Rodriguez** · UTN FrLP · Junio 2026

> Servidor Odoo activo por 7 días: `http://odoo.workshop.local`

---

> *"El mejor software es el que resuelve un problema real. El mejor ERP es el que tu equipo realmente usa."*

---

**📚 Recursos:**
- `docs/01_workshop_spec.md` — especificación completa
- `docs/02_presentacion_marp.md` — esta presentación
- `scripts/create_users.sh` — crea 40 usuarios
- `scripts/load_demo_data.sh` — carga datos demo

> **Fuentes:** Odoo Documentation 19.0 · Gartner Magic Quadrant 2024 · G2 Crowd 2025 · IDC ERP Report 2024

<!--

Cierre.

Dos cosas importantes:

1. El servidor Odoo va a estar activo por 7 días. Pueden volver
   a entrar, explorar, romper, y aprender.

2. Todos los materiales del workshop son open-source (CC BY-SA 4.0
   el contenido, LGPL-3 el código). Pueden llevárselos, modificarlos,
   y usarlos.

Mi objetivo hoy era mostrarles que:
- Un ERP no es una caja negra misteriosa
- Odoo está construido con tecnologías que ustedes ya conocen
- Desarrollar sobre Odoo es accesible y tiene salida laboral

Si les interesó el tema, hablen conmigo después y les paso más
recursos. Hay un mundo de oportunidades en el ecosistema Odoo.

Muchas gracias por venir y por la atención.
-->
---

*Versión 2.0 — Junio 2026 · Tema claro · Adaptado a proyector · Con notas de orador*
