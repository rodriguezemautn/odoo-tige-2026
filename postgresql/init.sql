-- ============================================================
-- Inicialización PostgreSQL para Workshop Odoo
-- ============================================================

-- Crear extensiones necesarias para Odoo
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- Búsqueda de texto

-- Configuración de encoding
SET client_encoding = 'UTF8';

-- Nota: Odoo crea su propio schema al inicializar.
-- Este script solo pre-configura extensiones.

DO $$
BEGIN
    RAISE NOTICE 'PostgreSQL version: %', version();
    RAISE NOTICE 'Workshop DB initialized successfully';
END $$;
