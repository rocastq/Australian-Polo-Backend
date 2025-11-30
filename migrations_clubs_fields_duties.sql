-- Migration for Clubs, Fields, and Duties tables
-- Run this SQL script on your MySQL database

-- ============================================
-- 1. CREATE CLUBS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS clubs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    founded_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Indexes for clubs
CREATE INDEX idx_clubs_name ON clubs(name);
CREATE INDEX idx_clubs_active ON clubs(is_active);
CREATE INDEX idx_clubs_location ON clubs(location);

-- ============================================
-- 2. CREATE FIELDS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS fields (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    grade ENUM('High Goal', 'Medium Goal', 'Low Goal', 'Zero', 'Sub-Zero') DEFAULT 'Medium Goal',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Indexes for fields
CREATE INDEX idx_fields_name ON fields(name);
CREATE INDEX idx_fields_active ON fields(is_active);
CREATE INDEX idx_fields_grade ON fields(grade);
CREATE INDEX idx_fields_location ON fields(location);

-- ============================================
-- 3. CREATE DUTIES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS duties (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Umpire', 'Centre Table', 'Goal Umpire') NOT NULL,
    date DATETIME NOT NULL,
    notes TEXT,
    player_id INT,
    match_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE SET NULL,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE SET NULL
);

-- Indexes for duties
CREATE INDEX idx_duties_date ON duties(date);
CREATE INDEX idx_duties_type ON duties(type);
CREATE INDEX idx_duties_player ON duties(player_id);
CREATE INDEX idx_duties_match ON duties(match_id);

-- ============================================
-- 4. ADD FOREIGN KEYS TO EXISTING TABLES
-- ============================================

-- Add club_id to teams table if it doesn't exist
SET @dbname = DATABASE();
SET @tablename = 'teams';
SET @columnname = 'club_id';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL, ADD FOREIGN KEY (', @columnname, ') REFERENCES clubs(id) ON DELETE SET NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add club_id to players table if it doesn't exist
SET @tablename = 'players';
SET @columnname = 'club_id';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL, ADD FOREIGN KEY (', @columnname, ') REFERENCES clubs(id) ON DELETE SET NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add field_id to tournaments table if it doesn't exist
SET @tablename = 'tournaments';
SET @columnname = 'field_id';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL, ADD FOREIGN KEY (', @columnname, ') REFERENCES fields(id) ON DELETE SET NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add field_id to matches table if it doesn't exist
SET @tablename = 'matches';
SET @columnname = 'field_id';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL, ADD FOREIGN KEY (', @columnname, ') REFERENCES fields(id) ON DELETE SET NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- ============================================
-- 5. VERIFICATION QUERIES (optional - uncomment to verify)
-- ============================================

-- SELECT 'Clubs table created' AS status;
-- SELECT * FROM clubs LIMIT 0;
--
-- SELECT 'Fields table created' AS status;
-- SELECT * FROM fields LIMIT 0;
--
-- SELECT 'Duties table created' AS status;
-- SELECT * FROM duties LIMIT 0;
--
-- SHOW TABLES;

-- ============================================
-- Migration complete!
-- ============================================
