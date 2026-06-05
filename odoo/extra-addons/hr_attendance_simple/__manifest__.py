# -*- coding: utf-8 -*-
{
    'name': 'Asistencia Simple — Workshop',
    'version': '19.0.1.0.0',
    'summary': 'Registro simple de entrada y salida para el workshop',
    'description': """
        Módulo ultra simple para registrar horas trabajadas.
        Cada usuario puede marcar entrada y salida, y ver su historial.
        Los administradores ven todos los registros.

        Demuestra:
        - Modelo ORM simple con campos básicos y computados
        - Seguridad por registro (record rules)
        - Botones de acción (check_in / check_out)
        - Vista tree, form, search
        - Datos de demostración
    """,
    'author': 'Workshop Ingeniería en Sistemas',
    'website': 'https://techfarma.com.ar',
    'category': 'Human Resources',
    'depends': ['base', 'mail'],
    'data': [
        'security/ir.model.access.csv',
        'security/attendance_security.xml',
        'views/attendance_views.xml',
    ],
    'demo': [
        'data/attendance_demo.xml',
    ],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}
