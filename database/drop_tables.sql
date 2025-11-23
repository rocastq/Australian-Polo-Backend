-- ============================================================================
-- DROP ALL TABLES (Use with caution!)
-- ============================================================================
-- This script will drop all tables in the database.
-- Use this for a complete reset or before running schema.sql for a fresh install.

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS awards;
DROP TABLE IF EXISTS rosters;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS horses;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS breeders;
DROP TABLE IF EXISTS tournaments;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- Verify all tables are dropped
SHOW TABLES;
