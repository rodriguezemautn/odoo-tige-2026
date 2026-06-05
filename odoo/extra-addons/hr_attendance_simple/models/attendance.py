# -*- coding: utf-8 -*-
from odoo import models, fields, api
from odoo.exceptions import UserError, ValidationError
from datetime import datetime, timedelta


class AttendanceSimple(models.Model):
    """
    Registro de asistencia simple: check-in / check-out.
    Cada usuario registra su entrada y salida manualmente.
    """
    _name = 'attendance.simple'
    _description = 'Registro de Asistencia'
    _order = 'check_in desc, id desc'
    _rec_name = 'display_name'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    # ── Campos básicos ──────────────────────────────────
    user_id = fields.Many2one(
        'res.users',
        string='Usuario',
        required=True,
        default=lambda self: self.env.user,
        tracking=True,
        help='Usuario que registra la asistencia',
    )
    check_in = fields.Datetime(
        string='Entrada',
        required=True,
        default=fields.Datetime.now,
        tracking=True,
        help='Fecha y hora de entrada',
    )
    check_out = fields.Datetime(
        string='Salida',
        tracking=True,
        help='Fecha y hora de salida (se completa al marcar salida)',
    )
    notes = fields.Text(
        string='Notas',
        help='Comentarios opcionales sobre la jornada',
    )

    # ── Campos computados ──────────────────────────────
    worked_hours = fields.Float(
        string='Horas Trabajadas',
        compute='_compute_worked_hours',
        store=True,
        digits=(5, 2),
        help='Diferencia entre salida y entrada en horas',
    )
    is_active = fields.Boolean(
        string='Jornada Activa',
        compute='_compute_is_active',
        store=True,
        help='Verdadero si tiene entrada pero no salida',
    )
    display_name = fields.Char(
        string='Nombre',
        compute='_compute_display_name',
        store=True,
    )

    @api.depends('check_in', 'check_out')
    def _compute_worked_hours(self):
        for record in self:
            if record.check_in and record.check_out:
                delta = record.check_out - record.check_in
                record.worked_hours = round(delta.total_seconds() / 3600, 2)
            else:
                record.worked_hours = 0.0

    @api.depends('check_in', 'check_out')
    def _compute_is_active(self):
        for record in self:
            record.is_active = bool(record.check_in and not record.check_out)

    @api.depends('user_id', 'check_in')
    def _compute_display_name(self):
        for record in self:
            user = record.user_id.name or 'Usuario'
            fecha = ''
            if record.check_in:
                fecha = record.check_in.strftime('%d/%m/%Y %H:%M')
            record.display_name = f'{user} - {fecha}'

    # ── Constraints ────────────────────────────────────
    @api.constrains('check_in', 'check_out')
    def _check_hours(self):
        for record in self:
            if record.check_in and record.check_out:
                if record.check_out <= record.check_in:
                    raise ValidationError(
                        'La hora de salida debe ser posterior a la de entrada.'
                    )

    # ── Acciones ───────────────────────────────────────
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

    # ── Búsqueda por defecto: solo mis registros ──────
    @api.model
    def default_get(self, fields_list):
        res = super().default_get(fields_list)
        if 'user_id' in fields_list and not res.get('user_id'):
            res['user_id'] = self.env.user.id
        return res


class ResUsers(models.Model):
    """Agrega un campo computado para acceder rápido a la asistencia activa"""
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
