# -*- coding: utf-8 -*-
from odoo import models, fields, api
from odoo.exceptions import ValidationError
from datetime import date


class IoTSensor(models.Model):
    """
    Modelo para gestionar sensores IoT instalados en campo.
    Demuestra: campos básicos, computed fields, constraints,
    onchange, herencia de mail.thread para chatter.
    """
    _name = 'techfarma.sensor'
    _description = 'Sensor IoT de Campo'
    _inherit = ['mail.thread', 'mail.activity.mixin']
    _order = 'installation_date desc, name asc'
    _rec_name = 'name'

    # ── Campos básicos ──────────────────────────────────
    name = fields.Char(
        string='Número de Serie',
        required=True,
        tracking=True,
        copy=False,
        help='Formato: TF-XXXXXXXX (ej: TF-20240001)',
    )
    product_id = fields.Many2one(
        'product.product',
        string='Producto',
        domain=[('type', '=', 'product')],
        help='Producto asociado al sensor',
    )
    partner_id = fields.Many2one(
        'res.partner',
        string='Cliente / Instalación',
        tracking=True,
        help='Cliente donde está instalado el sensor',
    )
    installation_date = fields.Date(
        string='Fecha de Instalación',
        default=fields.Date.today,
        tracking=True,
    )
    location_lat = fields.Float(
        string='Latitud',
        digits=(9, 6),
        help='Coordenada de latitud (ej: -34.921)',
    )
    location_lon = fields.Float(
        string='Longitud',
        digits=(9, 6),
        help='Coordenada de longitud (ej: -57.955)',
    )
    notes = fields.Text(
        string='Notas Técnicas',
        help='Observaciones técnicas del sensor',
    )
    active = fields.Boolean(
        string='Activo',
        default=True,
        help='Desmarcar para ocultar el registro sin eliminarlo',
    )

    # ── Campo de estado ────────────────────────────────
    state = fields.Selection([
        ('draft',        'Borrador'),
        ('active',       'Activo'),
        ('maintenance',  'En Mantenimiento'),
        ('retired',      'Retirado'),
    ], string='Estado', default='draft', tracking=True,
       required=True, index=True,
       group_expand='_expand_states')

    @api.model
    def _expand_states(self, states, domain, order):
        """Permite que los filtros agrupen por estados aunque no haya registros."""
        return [key for key, _ in self._fields['state'].selection]

    # ── Campos computados ──────────────────────────────
    days_active = fields.Integer(
        string='Días Activo',
        compute='_compute_days_active',
        store=False,
        help='Cantidad de días desde la instalación (solo si estado = Activo)',
    )
    is_overdue = fields.Boolean(
        string='Mantenimiento Vencido',
        compute='_compute_is_overdue',
        store=True,
        help='Indica si el sensor requiere mantenimiento (>365 días activo)',
    )
    display_name_short = fields.Char(
        string='Nombre Corto',
        compute='_compute_display_name_short',
        store=True,
    )

    @api.depends('installation_date', 'state')
    def _compute_days_active(self):
        today = date.today()
        for record in self:
            if record.installation_date and record.state == 'active':
                delta = today - record.installation_date
                record.days_active = delta.days
            else:
                record.days_active = 0

    @api.depends('days_active', 'state')
    def _compute_is_overdue(self):
        MAINTENANCE_INTERVAL = 365
        for record in self:
            record.is_overdue = (
                record.state == 'active' and
                record.days_active > MAINTENANCE_INTERVAL
            )

    @api.depends('name', 'state')
    def _compute_display_name_short(self):
        for record in self:
            record.display_name_short = (
                f"{record.name} [{dict(record._fields['state'].selection).get(record.state, '?')}]"
                if record.name else 'Nuevo Sensor'
            )

    # ── Constraints ────────────────────────────────────
    @api.constrains('name')
    def _check_serial_format(self):
        for record in self:
            if record.name and not record.name.startswith('TF-'):
                raise ValidationError(
                    "El número de serie debe comenzar con 'TF-' "
                    f"(actual: {record.name})"
                )

    @api.constrains('location_lat', 'location_lon')
    def _check_coordinates(self):
        for record in self:
            if record.location_lat and abs(record.location_lat) > 90:
                raise ValidationError(
                    f"Latitud inválida: {record.location_lat}. Debe estar entre -90 y 90."
                )
            if record.location_lon and abs(record.location_lon) > 180:
                raise ValidationError(
                    f"Longitud inválida: {record.location_lon}. Debe estar entre -180 y 180."
                )

    # ── Onchange ──────────────────────────────────────
    @api.onchange('product_id')
    def _onchange_product_id(self):
        if self.product_id:
            self.notes = f"Sensor tipo: {self.product_id.display_name}\n"

    # ── Métodos de negocio ────────────────────────────
    def action_activate(self):
        """Activar sensor (botón en vista form)."""
        for record in self:
            if record.state == 'draft':
                record.state = 'active'

    def action_send_to_maintenance(self):
        """Enviar a mantenimiento."""
        for record in self:
            if record.state == 'active':
                record.state = 'maintenance'

    def action_retire(self):
        """Retirar sensor definitivamente."""
        for record in self:
            if record.state in ('active', 'maintenance'):
                record.state = 'retired'

    # ── Acciones de servidor ──────────────────────────
    def action_open_partner(self):
        """Abrir el partner asociado (botón en vista form)."""
        self.ensure_one()
        return {
            'type': 'ir.actions.act_window',
            'name': 'Cliente',
            'res_model': 'res.partner',
            'res_id': self.partner_id.id,
            'view_mode': 'form',
            'target': 'current',
        }
