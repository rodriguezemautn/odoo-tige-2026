# Módulo `hr_attendance_simple` — Documentación Completa

## Índice

1. [Arquitectura General](#1-arquitectura-general)
2. [Estructura de Archivos](#2-estructura-de-archivos)
3. [`__manifest__.py` — El Manifiesto](#3-__manifest__py--el-manifiesto)
4. [`models/attendance.py` — El Corazón](#4-modelsattendancepy--el-corazón)
5. [`security/` — Permisos y Record Rules](#5-security--permisos-y-record-rules)
6. [`views/attendance_views.xml` — Las Vistas](#6-viewsattendance_viewxml--las-vistas)
7. [`data/attendance_demo.xml` — Datos Demo](#7-dataattendance_demoxml--datos-demo)
8. [Integración entre Componentes](#8-integración-entre-componentes)
9. [Flujo de Ejecución Completo](#9-flujo-de-ejecución-completo)
10. [Glosario de Conceptos Odoo](#10-glosario-de-conceptos-odoo)

---

## 1. Arquitectura General

Odoo sigue el patrón **MVC (Model-View-Controller)** adaptado a su propio framework ORM:

```
┌─────────────────────────────────────────────────────┐
│                    MANIFIESTO                        │
│              (__manifest__.py)                       │
│   Declara el módulo, sus dependencias y archivos     │
└──────────┬──────────┬─────────────┬──────────────────┘
           │          │             │
     ┌─────▼───┐ ┌───▼────┐  ┌────▼─────┐  ┌─────▼─────┐
     │ MODELOS  │ │ VISTAS │  │SEGURIDAD │  │DATOS DEMO │
     │  .py     │ │ .xml   │  │ .xml/.csv│  │   .xml    │
     │ ORM +    │ │  UI    │  │ Accesos  │  │ Registros │
     │ Lógica   │ │        │  │ + Reglas │  │ de prueba │
     └──────────┘ └────────┘  └──────────┘  └───────────┘
```

Cada capa es **independiente pero se integra** a través de **IDs XML** que Odoo usa como "pegamento" entre archivos. Por ejemplo, un modelo se declara en Python, se referencia en las vistas XML por su nombre técnico, y se protege en los archivos de seguridad por su ID.

---

## 2. Estructura de Archivos

```
hr_attendance_simple/
├── __init__.py                  ← Punto de entrada de Python
├── __manifest__.py              ← Declaración del módulo (metadatos)
├── models/
│   ├── __init__.py              ← Importa los modelos
│   └── attendance.py            ← Modelo ORM + herencia res.users
├── security/
│   ├── ir.model.access.csv      ← Permisos CRUD básicos (tabla)
│   └── attendance_security.xml  ← Record rules (reglas por registro)
├── views/
│   └── attendance_views.xml     ← Vistas UI + acciones + menú
└── data/
    └── attendance_demo.xml      ← Datos de demostración
```

**Regla de carga**: El manifiesto define el orden en que Odoo procesa los archivos:

```python
'data': [
    'security/ir.model.access.csv',      # 1°: permisos
    'security/attendance_security.xml',   # 2°: record rules
    'views/attendance_views.xml',         # 3°: vistas y menú
],
'demo': [
    'data/attendance_demo.xml',           # Solo si demo=True
],
```

> **Nota**: Los archivos de seguridad se cargan PRIMERO porque las vistas los referencian. Si un archivo de vista referencia un grupo que todavía no existe, Odoo falla.

---

## 3. `__manifest__.py` — El Manifiesto

```python
{
    'name': 'Asistencia Simple — Workshop',
    'version': '19.0.1.0.0',
    'summary': 'Registro simple de entrada y salida para el workshop',
    'description': """...""",
    'author': 'Workshop Ingeniería en Sistemas',
    'category': 'Human Resources',
    'depends': ['base', 'mail'],
    'data': [...],
    'demo': [...],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}
```

### Campos clave:

| Campo | Qué hace |
|-------|----------|
| `name` | Nombre visible en la lista de Apps |
| `depends` | Módulos ODOO que necesita. `base` es obligatorio siempre. `mail` nos da el chatter |
| `data` | Archivos a cargar SIEMPRE (vistas, seguridad, etc.) |
| `demo` | Archivos que solo se cargan si se instala con datos demo |
| `application` | `True` = aparece como App independiente en el menú de apps |
| `installable` | Si está en False, Odoo no permite instalarlo |
| `auto_install` | Si está en True, se instala automáticamente cuando se instalan todas sus dependencias |

**¿Por qué depende de `mail`?** Porque nuestro modelo hereda de `mail.thread` para tener el chatter (el panel de mensajes y seguimiento de cambios). Sin `mail` instalado, Odoo no encuentra la clase `mail.thread` y falla.

---

## 4. `models/attendance.py` — El Corazón

### 4.1. `class AttendanceSimple(models.Model)`

```python
class AttendanceSimple(models.Model):
    _name = 'attendance.simple'           # ← IDENTIFICADOR ÚNICO del modelo
    _description = 'Registro de Asistencia'
    _order = 'check_in desc, id desc'     # ← Orden por defecto en listas
    _rec_name = 'display_name'            # ← Campo usado al mostrar enlaces
    _inherit = ['mail.thread', 'mail.activity.mixin']  # ← Hereda comportamiento
```

**Conceptos clave**:

- **`_name`**: Es el identificador técnico del modelo en todo Odoo. Se usa en vistas (`res_model="attendance.simple"`), en seguridad (`model_attendance_simple`), y en el ORM para hacer queries.
- **`_inherit`**: Le decimos a Odoo "comportate como mail.thread". Esto agrega automáticamente:
  - Campo `message_ids`: los mensajes del chatter
  - Campo `message_follower_ids`: seguidores del registro
  - Métodos `message_post()`: para postear mensajes
  - Tracking automático: si un campo tiene `tracking=True`, Odoo registra los cambios en el chatter
  
- **`_rec_name`**: Cuando otro modelo hace una relación Many2one a `attendance.simple`, Odoo muestra este campo como texto. Por defecto usa `name`, pero como nosotros no tenemos campo `name`, le decimos que use `display_name` (que computamos nosotros).

- **`_order`**: Define el ORDER BY SQL por defecto. `check_in desc` = más recientes primero.

### 4.2. Campos básicos

```python
user_id = fields.Many2one(
    'res.users',
    string='Usuario',
    required=True,
    default=lambda self: self.env.user,    # ← Usuario logueado por defecto
    tracking=True,
)

check_in = fields.Datetime(
    string='Entrada',
    required=True,
    default=fields.Datetime.now,           # ← Hora actual por defecto
    tracking=True,
)

check_out = fields.Datetime(
    string='Salida',
    tracking=True,
)
```

**Conceptos clave**:

- **`fields.Many2one('res.users', ...)`**: Crea una clave foránea a la tabla `res_users`. En la BD se traduce como `user_id INT REFERENCES res_users(id)`.
- **`default=lambda self: self.env.user`**: La función lambda se ejecuta en el contexto del modelo. `self.env.user` es el usuario que está haciendo la operación. Es una **función dinámica** (se evalúa en cada creación), no un valor fijo.
- **`default=fields.Datetime.now`**: Es una función que devuelve la fecha/hora UTC actual del servidor.
- **`tracking=True`**: Activa el **chatter tracking**. Cuando alguien modifica este campo, Odoo automáticamente postea un mensaje en el chatter diciendo "Campo X cambió de 'valor viejo' a 'valor nuevo'".

### 4.3. Campos computados

```python
worked_hours = fields.Float(
    string='Horas Trabajadas',
    compute='_compute_worked_hours',
    store=True,
    digits=(5, 2),
)

is_active = fields.Boolean(
    string='Jornada Activa',
    compute='_compute_is_active',
    store=True,
)

display_name = fields.Char(
    string='Nombre',
    compute='_compute_display_name',
    store=True,
)
```

**Concepto clave**: Los campos computados NO se guardan en la BD a menos que tengan `store=True`. Su valor se calcula con una función Python cada vez que se leen o cuando sus dependencias cambian.

#### `_compute_worked_hours`

```python
@api.depends('check_in', 'check_out')
def _compute_worked_hours(self):
    for record in self:
        if record.check_in and record.check_out:
            delta = record.check_out - record.check_in
            record.worked_hours = round(delta.total_seconds() / 3600, 2)
        else:
            record.worked_hours = 0.0
```

- **`@api.depends('check_in', 'check_out')`**: Decorador que declara de qué campos depende este cálculo. Odoo REcalcula automáticamente `worked_hours` cuando cambian `check_in` o `check_out`.
- **`self` es un RECORDSET**: Puede contener MÚLTIPLES registros. Por eso iteramos con `for record in self`.
- El cálculo: resta las fechas Python (da un `timedelta`), lo convierte a segundos y divide por 3600 para obtener horas.

#### `_compute_is_active`

```python
@api.depends('check_in', 'check_out')
def _compute_is_active(self):
    for record in self:
        record.is_active = bool(record.check_in and not record.check_out)
```

Simple: está activo si tiene entrada pero NO tiene salida.

#### `_compute_display_name`

```python
@api.depends('user_id', 'check_in')
def _compute_display_name(self):
    for record in self:
        user = record.user_id.name or 'Usuario'
        fecha = ''
        if record.check_in:
            fecha = record.check_in.strftime('%d/%m/%Y %H:%M')
        record.display_name = f'{user} - {fecha}'
```

Genera un nombre legible como "BACCARINI, CAMILA - 05/06/2026 08:30".

### 4.4. Constraints

```python
@api.constrains('check_in', 'check_out')
def _check_hours(self):
    for record in self:
        if record.check_in and record.check_out:
            if record.check_out <= record.check_in:
                raise ValidationError(
                    'La hora de salida debe ser posterior a la de entrada.'
                )
```

- **`@api.constrains(...)`**: Se ejecuta en cada `create()` o `write()`. Si levanta `ValidationError`, Odoo REVIERTE la transacción (rollback) y muestra el error al usuario.
- Es una validación a nivel base de datos (no solo UI).

### 4.5. Acciones (botones)

```python
def action_check_out(self):
    """Marca la salida del registro activo."""
    for record in self:
        if record.check_out:
            raise UserError('Este registro ya tiene hora de salida.')
        record.write({
            'check_out': fields.Datetime.now(),
        })

def action_reset(self):
    """Permite reiniciar un registro (solo si se equivocó)."""
    for record in self:
        record.write({
            'check_out': False,
            'check_in': fields.Datetime.now(),
        })
```

- **`UserError`**: Error amigable que Odoo muestra al usuario en una ventana emergente. No revierte la transacción (a diferencia de `ValidationError`).
- **`record.write({...})`**: Método del ORM para actualizar campos. No ejecuta validaciones de UI, pero SÍ ejecuta constraints y recomputaciones.

### 4.6. `default_get`

```python
@api.model
def default_get(self, fields_list):
    res = super().default_get(fields_list)
    if 'user_id' in fields_list and not res.get('user_id'):
        res['user_id'] = self.env.user.id
    return res
```

- **`@api.model`**: Se ejecuta a nivel de modelo (no de registro).
- **`default_get`**: Odoo lo llama para obtener los valores por defecto al abrir un formulario de creación. Nos aseguramos de que `user_id` tenga al usuario logueado por más que el contexto no lo provea.

### 4.7. Herencia de `res.users`

```python
class ResUsers(models.Model):
    _inherit = 'res.users'

    active_attendance_id = fields.Many2one(
        'attendance.simple',
        string='Asistencia Activa',
        compute='_compute_active_attendance',
    )

    def _compute_active_attendance(self):
        for user in self:
            active = self.env['attendance.simple'].search([
                ('user_id', '=', user.id),
                ('is_active', '=', True),
            ], limit=1)
            user.active_attendance_id = active.id if active else False
```

**Concepto clave**: `_inherit` sin `_name` = **HERENCIA EXTENSIBLE**. No creamos un modelo nuevo, sino que AGREGAMOS un campo al modelo `res.users` existente. Esto se conoce en Odoo como "inheritance by extension" o "monkey-patching ordenado".

El campo `active_attendance_id` es un Many2one computado que busca el registro de asistencia activo del usuario. Sirve para futuros usos (ej: mostrar en dashboard "Tenés una jornada activa").

---

## 5. Security — Permisos y Record Rules

### 5.1. `ir.model.access.csv`

```csv
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_attendance_simple_user,attendance.simple.user,model_attendance_simple,base.group_user,1,1,1,0
access_attendance_simple_admin,attendance.simple.admin,model_attendance_simple,base.group_system,1,1,1,1
```

**Qué hace**: Define qué **modelos** puede ver cada grupo.

| Columna | Significado |
|---------|-------------|
| `id` | ID XML único del permiso |
| `model_id:id` | El modelo (referencia por su ID XML: `model_{_name}`) |
| `group_id:id` | El grupo de usuarios |
| `perm_read` | 1 = puede LEER registros |
| `perm_write` | 1 = puede MODIFICAR registros |
| `perm_create` | 1 = puede CREAR registros |
| `perm_unlink` | 1 = puede BORRAR registros |

**Estrategia**:
- **Usuario común** (`base.group_user`): read/write/create, pero NO borrar (perm_unlink=0)
- **Administrador** (`base.group_system`): TODO (perm_unlink=1)

### 5.2. `attendance_security.xml` — Record Rules

```xml
<!-- Regla para usuarios normales: solo ven SUS registros -->
<record id="rule_attendance_simple_user" model="ir.rule">
    <field name="model_id" ref="model_attendance_simple"/>
    <field name="domain_force">[('user_id', '=', user.id)]</field>
    <field name="groups" eval="[(4, ref('base.group_user'))]"/>
    <field name="perm_read" eval="True"/>
    <field name="perm_write" eval="True"/>
    <field name="perm_create" eval="True"/>
    <field name="perm_unlink" eval="False"/>
</record>

<!-- Regla para admins: ven TODO -->
<record id="rule_attendance_simple_admin" model="ir.rule">
    <field name="model_id" ref="model_attendance_simple"/>
    <field name="domain_force">[(1, '=', 1)]</field>
    <field name="groups" eval="[(4, ref('base.group_system'))]"/>
    ...
</record>
```

**¿Por qué necesitamos record rules si ya tenemos access.csv?**
- **access.csv**: Controla si un grupo PUEDE o NO acceder al modelo (permiso de "entrar a la tabla")
- **record rules**: Controla qué REGISTROS puede ver dentro de esa tabla (filtro a nivel fila)

El dominio `[('user_id', '=', user.id)]` usa una variable especial de Odoo: `user.id` es el ID del usuario logueado en ese momento. Entonces cada uno ve solo donde `user_id = su propio ID`.

**`(1, '=', 1)`** es un dominio que significa "siempre verdadero" (es como `WHERE 1=1` en SQL). Así los admins ven todo.

---

## 6. `views/attendance_views.xml` — Las Vistas

Este archivo es el más largo porque define varios componentes:

### 6.1. Acción de ventana

```xml
<record id="action_attendance_simple" model="ir.actions.act_window">
    <field name="name">Mi Asistencia</field>
    <field name="res_model">attendance.simple</field>
    <field name="view_mode">list,form</field>
</record>
```

Una **acción** es el "puente" entre un menú y las vistas. Define:
- `res_model`: a qué modelo va a acceder
- `view_mode`: qué vistas va a mostrar (en orden: primero lista, después formulario)

### 6.2. Menú

```xml
<menuitem id="menu_attendance_root"
          name="Asistencia"
          sequence="95"
          web_icon="hr_attendance,static/description/icon.png"/>

<menuitem id="menu_attendance_my"
          name="Mi Asistencia"
          parent="menu_attendance_root"
          action="action_attendance_simple"
          sequence="10"/>
```

- **`parent`**: jerarquía del menú (root → submenú)
- **`action`**: qué acción ejecuta al hacer click
- **`web_icon`**: ícono que aparece en el App Switcher (tomamos prestado el de hr_attendance)

### 6.3. Vista Lista

```xml
<list decoration-success="is_active == True"
      decoration-muted="check_out != False">
    <field name="user_id" optional="show"/>
    <field name="check_in"/>
    <field name="check_out"/>
    <field name="worked_hours" sum="Total"/>
</list>
```

**Decorations**: Cambian el color de la fila según condiciones:
- `decoration-success="is_active == True"` → verde si está activo
- `decoration-muted="check_out != False"` → gris si ya tiene salida

Atributo `sum="Total"` en `worked_hours`: Muestra la sumatoria al pie de la columna.

### 6.4. Vista Formulario

```xml
<form>
    <header>
        <button name="action_check_out" type="object"
                string="Marcar Salida" class="btn-primary"
                invisible="check_out != False"/>
        <button name="action_reset" type="object"
                string="Reiniciar"
                invisible="check_out != False"/>
    </header>
    <sheet>
        <group>
            <field name="user_id"/>
            <field name="check_in" widget="datetime"/>
            <field name="check_out" widget="datetime"/>
        </group>
        <!-- ... -->
    </sheet>
</form>
```

- **`<header>`**: Barra superior con botones de acción
- **`button type="object"`**: Llama a un método Python del modelo (`action_check_out`)
- **`invisible`**: El botón "Marcar Salida" solo se muestra si NO tiene salida aún
- **`confirm`**: En el botón Reiniciar, muestra un diálogo de confirmación antes de ejecutar
- **`statusbar`**: Muestra el estado en la barra superior (si hubiera un campo state)

### 6.5. Vista Search

```xml
<search>
    <field name="user_id"/>
    <field name="check_in"/>
    <filter name="filter_active"
            string="Jornada Activa"
            domain="[('is_active', '=', True)]"/>
    <filter name="group_user"
            string="Usuario"
            context="{'group_by': 'user_id'}"/>
</search>
```

- **`<field>`**: Campos de búsqueda rápida
- **`<filter domain="...">`**: Filtros predefinidos (toggle)
- **`<filter context="{'group_by': '...'}">`: Filtros de agrupación

---

## 7. `data/attendance_demo.xml` — Datos Demo

```xml
<record id="attendance_demo_001" model="attendance.simple">
    <field name="user_id" ref="base.user_admin"/>
    <field name="check_in" eval="(DateTime.now() - timedelta(days=1)).strftime('%Y-%m-%d 08:30:00')"/>
    <field name="check_out" eval="(DateTime.now() - timedelta(days=1)).strftime('%Y-%m-%d 17:15:00')"/>
    <field name="notes">Jornada completa de prueba.</field>
</record>
```

- **`ref="base.user_admin"`**: Referencia a un registro existente por su XML ID. `base.user_admin` es el usuario administrador que Odoo crea por defecto.
- **`eval="..."`**: Evalúa una expresión Python. `DateTime.now()` es la función `odoo.fields.Datetime.now()`. `timedelta(days=1)` resta un día. `strftime(...)` formatea la fecha.

**¿Por qué está en `demo` y no en `data`?** Porque solo queremos que se cargue si se instala el módulo con `demo=True`. Si es una instalación productiva, no se cargan datos demo.

---

## 8. Integración entre Componentes

Así se conectan todas las piezas:

```
__manifest__.py
│
├── depends: ['base', 'mail']          ← Asegura que existan mail.thread, res.users, etc.
│
├── data: security/ir.model.access.csv ← Se cargan los permisos primero
│                                          Crea registros en ir.model.access
│                                          Referencia: model_attendance_simple (se genera automágicamente)
│                                                     base.group_user, base.group_system (existen en base)
│
├── data: security/attendance_security.xml ← Crea registros en ir.rule
│                                              Referencia: model_attendance_simple (de nuevo)
│                                                         base.group_user, base.group_system
│
├── data: views/attendance_views.xml   ← Crea acciones, menú, vistas
│                                          Referencia: attendance.simple (el _name del modelo)
│                                                     action_check_out, action_reset (métodos de attendance.py)
│
└── demo: data/attendance_demo.xml     ← Crea registros de prueba
                                           Referencia: base.user_admin (existe en base)
                                                        attendance.simple (el modelo)
```

### Diagrama de relaciones:

```
[res.users] ──1:N──> [attendance.simple]   (user_id)
                           │
                    ┌──────┴──────┐
                    │             │
           [ir.actions.act_window]  [ir.ui.view]
                    │             │
                    └──────┬──────┘
                           │
                   [ir.ui.menu] (Asistencia > Mi Asistencia)
```

### El "pegamento": las IDs XML

Odoo asigna un **ID XML** (también llamado "external ID") a cada registro creado desde un archivo XML. Por ejemplo:

| ID XML | Modelo | Registro |
|--------|--------|----------|
| `base.group_user` | res.groups | Grupo "Usuario Interno" |
| `base.group_system` | res.groups | Grupo "Administrador" |
| `model_attendance_simple` | ir.model | Modelo `attendance.simple` (automático) |
| `base.user_admin` | res.users | Usuario admin |

Cuando en un archivo XML escribimos `ref="base.group_user"`, Odoo busca ese ID XML en la tabla `ir.model.data` y lo reemplaza por el ID numérico correspondiente.

---

## 9. Flujo de Ejecución Completo

### Cuando un usuario hace click en "Marcar Entrada":

```
1. CLICK "Nuevo"
   │
2. Odoo busca action_attendance_simple (ir.actions.act_window)
   │ res_model = attendance.simple
   │ view_mode = list,form
   │
3. Odoo llama a default_get() del modelo attendance.simple
   │ user_id = self.env.user (el usuario logueado)
   │ check_in = datetime.now()
   │
4. Odoo renderiza view_attendance_simple_form (vista form)
   │ Muestra los campos con valores por defecto
   │
5. USUARIO COMPLETA notas y guarda
   │
6. Odoo llama a create() del modelo attendance.simple
   │
7. El ORM ejecuta:
   │  a. Validación de campos requeridos
   │  b. Constraints (_check_hours)
   │  c. Escritura en BD
   │  d. Recomputation de campos dependientes
   │  e. Posteo en chatter (si hay cambios tracking)
   │
8. Odoo redirige a la vista form del registro creado
```

### Cuando un usuario hace click en "Marcar Salida":

```
1. CLICK botón "Marcar Salida"
   │
2. Odoo ejecuta action_check_out() en el registro actual
   │
3. El método verifica que no tenga check_out
   │
4. write({'check_out': datetime.now()})
   │
5. El ORM:
   │  a. Actualiza check_out en BD
   │  b. Recomputa worked_hours (depende de check_out)
   │  c. Recomputa is_active (depende de check_out)
   │  d. Recomputa display_name (depende de user_id)
   │  e. Postea en chatter: "check_out cambió de False a 05/06/2026 17:15"
   │
6. La UI se actualiza (el registro ya no está verde, ahora está gris)
```

### Cuando un admin ve la lista:

```
1. Odoo ejecuta search() en attendance.simple
   │
2. Se aplican las record rules:
   │  rule_attendance_simple_admin → domain_force = [(1, '=', 1)]
   │  → TODOS los registros
   │
3. Se aplica el orden: _order = 'check_in desc'
   │
4. Se renderiza la vista list con decorations:
   │  Verde para is_active = True
   │  Gris para check_out != False
```

### Cuando un usuario NO-admin ve la lista:

```
1. Odoo ejecuta search() en attendance.simple
   │
2. Se aplican record rules:
   │  rule_attendance_simple_user → domain_force = [('user_id', '=', user.id)]
   │  → Solo registros donde user_id = 49 (por ejemplo)
   │  rule_attendance_simple_admin también existe pero:
   │    su grupo es group_system, el usuario NO está en ese grupo
   │    → NO se aplica esta regla
   │
3. Resultado: el usuario ve SOLO sus propios registros
```

---

## 10. Glosario de Conceptos Odoo

| Término | Significado |
|---------|-------------|
| **ORM** | Object-Relational Mapping. Capa que permite trabajar con la BD usando objetos Python en vez de SQL |
| **Recordset** | Conjunto de registros del ORM. `self` en los métodos es siempre un recordset |
| **`@api.depends`** | Decorador que declara dependencias de un campo computado |
| **`@api.constrains`** | Decorador para validaciones a nivel BD |
| **`@api.model`** | Método que opera a nivel modelo (no sobre un registro específico) |
| **XML ID** | Identificador único alfanumérico para un registro (ej: `base.group_user`) |
| **`ref()`** | Función que busca un registro por su XML ID |
| **`self.env`** | Objeto de entorno: contiene el usuario logueado, la BD, etc. |
| **`self.env.user`** | El usuario que ejecuta la operación actual |
| **Tracking** | Sistema que registra cambios de campos en el chatter automáticamente |
| **Chatter** | Panel inferior de los formularios con mensajes, seguimiento y actividades |
| **Record Rule** | Filtro a nivel de registro que restringe qué filas puede ver un usuario |
| **Decoration** | Atributos CSS condicionales en vistas (success, danger, muted, etc.) |
| **`button type="object"`** | Botón que llama a un método Python del modelo |
| **`invisible`** | Atributo de vista que oculta condicionalmente un elemento |
| **Many2one** | Relación N:1. Campo que apunta a otro modelo |
| **Compute** | Campo cuyo valor se calcula, no se almacena (a menos que tenga `store=True`) |
| **`store=True`** | Persiste el valor computado en la BD (mejor performance en listas) |
| **`_inherit` vs `_name`** | `_inherit` sin `_name` extiende un modelo existente. Con `_name` y `_inherit` crea uno nuevo que hereda |
| **`_inherits`** | Herencia por delegación (composicion). Similar a `extends` en POO clásica |
