# 🧪 Experiencias del Workshop — TechFarma S.A.

## Antes de arrancar

Cada estudiante tiene que:
1. Abrir el navegador en **http://192.168.0.26**
2. Iniciar sesión con el usuario asignado por el docente
3. Password para todos: **TechFarma2026!**

---

## 🏢 Grupo 1 — Ventas & CRM

**Rol en Odoo:** Salesman  
**Apps disponibles:** CRM, Ventas

### Ya existe
- 39 oportunidades en CRM (algunas asignadas a miembros del grupo)
- 26 pedidos de venta en distintos estados
- Clientes, productos y listas de precios

### 🎯 Actividades

#### 1. Explorar el CRM
1. Ir a **CRM → Tablero**
2. Ver las oportunidades agrupadas por etapa
3. Cambiar la vista a **Lista** para ver todas las oportunidades

#### 2. Avanzar una oportunidad
1. Elegir una oportunidad en **Calificado** o **Propuesta**
2. Agregar una nota interna en el chatter
3. Programar una **Siguiente Actividad** (llamada o reunión)
4. Cambiar la etapa de la oportunidad

#### 3. Crear un presupuesto (cotización)
1. Ir a **Ventas → Crear**
2. Cliente: **AgroSol Pampa S.A.**
3. Agregar línea:
   - Producto: **Kit Sensor IoT Completo**, Cantidad: 10
   - Producto: **Sensor IoT Suelo Pro**, Cantidad: 25
4. Confirmar el presupuesto → se convierte en **Pedido de Venta**

#### 4. Crear una oportunidad nueva
1. CRM → **Nuevo**
2. Nombre: *"Potencial cliente — [tu nombre]"*
3. Cliente: **Granja Digital Chile**
4. Ingresos esperados: \$50.000
5. Probabilidad: 30%

#### 5. Seguir un pedido hasta la entrega
1. Buscar un **Pedido de Venta** confirmado
2. Ir a **Entrega** → verificar el albarán creado
3. Ir a **Factura** → crear factura desde el pedido

---

## 📦 Grupo 2 — Supply Chain

**Rol en Odoo:** Compras + Inventario  
**Apps disponibles:** Compras, Inventario

### Ya existe
- 12 órdenes de compra en distintos estados
- 4 pedidos confirmados
- Productos con stock (76 quants)
- 5 proveedores activos

### 🎯 Actividades

#### 1. Explorar el Inventario
1. Ir a **Inventario → Productos**
2. Revisar cantidades disponibles de cada producto
3. Ir a **Movimientos de Stock** y ver las últimas entradas/salidas

#### 2. Crear una orden de compra
1. Ir a **Compras → Crear**
2. Proveedor: **ElectroComp S.A.**
3. Agregar productos:
   - **Microcontrolador ESP32** — 200 unidades — \$6.00 c/u
   - **Carcasa Plástica ABS** — 300 unidades — \$3.50 c/u
4. Confirmar la OC

#### 3. Recibir productos en inventario
1. Ir a la OC confirmada
2. Click en **Validar** → **Recibir Productos**
3. Verificar que el stock se actualice en **Inventario → Productos**

#### 4. Transferir stock entre almacenes
1. Ir a **Inventario → Operaciones → Transferencias**
2. Crear una transferencia:
   - De: *Stock* → A: *Tu Almacén*
   - Producto: **Sensor IoT Suelo Basic** — 20 unidades
3. Validar la transferencia

#### 5. Hacer un inventario (recuento)
1. Ir a **Inventario → Operaciones → Ajustes de Inventario**
2. Crear un nuevo recuento
3. Elegir un producto y ajustar la cantidad
4. Validar

---

## 🏭 Grupo 3 — Manufactura

**Rol en Odoo:** Manufactura + Inventario  
**Apps disponibles:** Fabricación, Inventario

### Ya existe
- 8 listas de materiales (LMoM/BOMs)
- 8 órdenes de fabricación (OFs)
- Productos componentes en stock

### 🎯 Actividades

#### 1. Explorar la Lista de Materiales
1. Ir a **Fabricación → Productos → Lista de Materiales**
2. Elegir una LMoM y ver sus componentes
3. Ver la **Estructura del producto** en vista gráfica

#### 2. Crear una orden de fabricación
1. Ir a **Fabricación → Operaciones → Órdenes de Fabricación**
2. Crear nueva OF
3. Producto a fabricar: elegir uno de los que tienen LMoM
4. Cantidad: 50 unidades
5. Confirmar la OF → se reservan los componentes automáticamente

#### 3. Completar la fabricación
1. Ir a la OF y click en **Validar**
2. Ir a **Registrar Producción** (pestaña *Productos Fabricados*)
3. Confirmar la cantidad fabricada
4. Ir a **Inventario → Productos** y verificar que el producto aparezca en stock

#### 4. Crear un producto con LMoM
1. Ir a **Fabricación → Lista de Materiales → Crear**
2. Producto fabricado: elegir un producto existente (ej: *Sensor IoT Suelo Pro*)
3. Tipo de LMoM: *Fabricar este producto*
4. Agregar componentes:
   - **Microcontrolador ESP32** — 1 unidad
   - **Carcasa Plástica ABS** — 1 unidad
   - **Kit Sensor IoT Completo** — 1 unidad
5. Guardar

---

## 💰 Grupo 4 — Contabilidad

**Rol en Odoo:** Contador  
**Apps disponibles:** Facturación, Contabilidad

### Ya existe
- 18 facturas de cliente emitidas
- 4 facturas de proveedor
- 56 movimientos contables
- Plan de cuentas completo

### 🎯 Actividades

#### 1. Explorar el Dashboard contable
1. Ir a **Contabilidad → Dashboard**
2. Ver los indicadores: facturas por vencer, saldos, etc.
3. Ir a **Clientes → Facturas** y ver las emitidas

#### 2. Crear una factura de venta
1. Ir a **Facturación → Crear**
2. Tipo: **Factura de Cliente**
3. Cliente: **Campo Verde Distribuciones**
4. Agregar línea: **Gateway LoRa 4G** — 5 unidades — \$449.99
5. **Validar** la factura

#### 3. Registrar un pago
1. Ir a la factura recién creada
2. Click en **Registrar Pago**
3. Método de pago: **Transferencia Bancaria**
4. Monto: Total de la factura
5. Validar el pago → la factura pasa a "Pagada"

#### 4. Crear una factura de proveedor
1. Ir a **Facturación → Crear**
2. Tipo: **Factura de Proveedor**
3. Proveedor: **ElectroComp S.A.**
4. Agregar línea: *Microcontroladores ESP32* — 500 unidades — \$5.00 c/u
5. Validar

#### 5. Ver reportes contables
1. Ir a **Contabilidad → Reportes → Balance General**
2. Cambiar período y ver cómo se actualizan los saldos
3. Probar el **Libro Diario** y el **Mayor**

---

## 👥 Grupo 5 — RRHH & Proyectos

**Rol en Odoo:** Empleados + Proyectos  
**Apps disponibles:** Empleados, Proyecto, Reclutamiento

### Ya existe
- 21 empleados cargados
- 7 departamentos
- 5 proyectos con 64 tareas
- Proyecto "TechFarma IoT" con tareas demo

### 🎯 Actividades

#### 1. Explorar empleados
1. Ir a **Empleados → Empleados**
2. Ver la ficha de cada empleado
3. Ir al **Dashboard de RRHH** y ver los indicadores

#### 2. Crear un empleado nuevo
1. **Empleados → Crear**
2. Nombre: *[tu nombre]*
3. Departamento: elegir uno
4. Correo: usar el personal
5. Teléfono y datos de contacto
6. Guardar

#### 3. Explorar proyectos
1. Ir a **Proyecto → Proyectos**
2. Abrir **Proyecto TechFarma IoT**
3. Ver las tareas existentes en vista **Kanban**

#### 4. Crear tareas y asignarlas
1. Dentro del proyecto TechFarma IoT, crear nueva tarea
2. Título: *"Capacitación en campo — [tu nombre]"*
3. Asignar a un compañero de otro grupo (por su usuario)
4. Fecha límite: próxima semana
5. Cambiar la tarea de etapa según avance

#### 5. Probar Reclutamiento
1. Ir a **Reclutamiento → Crear**
2. Puesto: *"Ingeniero en Sistemas IoT"*
3. Departamento: *Producción*
4. Descripción breve del puesto
5. Publicar o dejar en borrador

---

## 🔧 Módulo Custom — Sensores IoT TechFarma

**Disponible para:** Todos los grupos (acceso al modelo techfarma.sensor)

### Ya existe
- 5 sensores cargados: 3 activos, 1 en mantenimiento, 1 retirado
- Productos asociados (tipo sensor)
- Clientes asignados

### 🎯 Actividades

#### 1. Explorar Sensores IoT
1. Ir al menú **TechFarma → Sensores IoT**
2. Probar las vistas: **Kanban**, **Lista**, **Formulario**
3. Usar los filtros: Activos, En Mantenimiento

#### 2. Registrar un sensor nuevo
1. **Crear** un nuevo sensor
2. N° de Serie: `TF-2025[XX]` (elegir un número)
3. Producto: *Sensor IoT Suelo Pro*
4. Cliente: *AgroSol Pampa S.A.*
5. Fecha de instalación: hoy
6. Estado: *Borrador*
7. Click en **Activar**

#### 3. Simular ciclo de vida
1. En un sensor activo, click en **Enviar a Mantenimiento**
2. Ver cómo cambia el estado y el color en la lista
3. Click en **Retirar** para darlo de baja

#### 4. Ver el chatter
1. Abrir un sensor y usar el chatter (historial)
2. Agregar un mensaje o una nota interna
3. Seguir el registro de cambios (tracking)

---

## 📋 Resumen de datos disponibles

| Dato | Cantidad |
|------|----------|
| Productos totales | 74 |
| Clientes | 14 |
| Proveedores | 7 |
| Pedidos de venta | 26 |
| Órdenes de compra | 12 |
| LMoM (BOM) | 8 |
| Órdenes de fabricación | 8 |
| Facturas cliente | 18 |
| Facturas proveedor | 4 |
| Empleados | 21 |
| Proyectos | 5 |
| Tareas | 64 |
| Oportunidades CRM | 39 |
| Sensores IoT (custom) | 5 |

---

## 🚀 Bonus — Desafíos extra

Si terminás todas las actividades de tu grupo, probá alguno de estos:

1. **Crear un partner** desde el formulario de sensor (botón Cliente)
2. **Vincular una venta** con un proyecto (al confirmar un pedido)
3. **Ver el diagrama de Gantt** del proyecto desde la vista de tareas
4. **Exportar a Excel** cualquier lista usando el botón 📥
5. **Crear un informe personalizado** desde cualquier vista
6. **Probar la búsqueda** con filtros avanzados y agrupaciones
7. **Dejar un mensaje** en el chatter de un sensor para otro grupo
