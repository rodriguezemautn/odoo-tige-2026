# -*- coding: utf-8 -*-
{
    'name': 'TechFarma Custom — Módulo Demo Workshop',
    'version': '19.0.1.0.0',
    'summary': 'Gestión de sensores IoT y contratos para TechFarma S.A.',
    'description': """
        Módulo creado durante el Workshop de Odoo para
        Ingeniería en Sistemas de Información.

        Demuestra la estructura mínima de un módulo Odoo:
        - Modelo ORM con campos básicos, computed fields, constraints
        - Vista tree, form, kanban, search
        - Control de acceso por rol
        - Datos de demostración
        - Chatter (mail.thread) para trazabilidad
    """,
    'author': 'Workshop Ingeniería en Sistemas',
    'website': 'https://techfarma.local',
    'category': 'Manufacturing',
    'depends': [
        'base',
        'mail',
        'product',
        'sale_management',
    ],
    'data': [
        'security/security.xml',
        'security/ir.model.access.xml',
        'views/sensor_views.xml',
    ],
    'demo': [
        'data/sensor_demo_data.xml',
    ],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}
