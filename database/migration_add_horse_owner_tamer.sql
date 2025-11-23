-- ============================================================================
-- Migration: Add Owner and Tamer fields to Horses table
-- Date: 2025-11-23
-- Description: Adds owner and tamer columns to existing horses table
-- ============================================================================

USE aupolo;

-- Add owner column
ALTER TABLE horses
ADD COLUMN owner VARCHAR(100) NULL COMMENT 'Horse owner name'
AFTER breeder_id;

-- Add tamer column
ALTER TABLE horses
ADD COLUMN tamer VARCHAR(100) NULL COMMENT 'Horse tamer/trainer name'
AFTER owner;

-- Add indexes for better query performance
ALTER TABLE horses
ADD INDEX idx_owner (owner),
ADD INDEX idx_tamer (tamer);

-- Verify the changes
DESCRIBE horses;

-- Check if migration was successful
SELECT 'Migration completed successfully' as status;
