-- Migration for Player Handicaps Import
-- Run this SQL script on your MySQL database

-- ============================================
-- 1. BACKUP AND CLEAR EXISTING PLAYERS
-- ============================================
-- Clear existing player data (as requested)
DELETE FROM players;

-- ============================================
-- 2. ALTER PLAYERS TABLE SCHEMA
-- ============================================

-- Drop the old 'name' column and add new columns
SET @dbname = DATABASE();
SET @tablename = 'players';

-- Add first_name column if not exists
SET @columnname = 'first_name';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' VARCHAR(100) NOT NULL DEFAULT ""')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add surname column if not exists
SET @columnname = 'surname';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' VARCHAR(100) NOT NULL DEFAULT ""')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add state column if not exists
SET @columnname = 'state';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' ENUM("NSW", "VIC", "QLD", "SA", "WA") NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add handicap_jun_2025 column if not exists
SET @columnname = 'handicap_jun_2025';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add womens_handicap_jun_2025 column if not exists
SET @columnname = 'womens_handicap_jun_2025';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add handicap_dec_2026 column if not exists
SET @columnname = 'handicap_dec_2026';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add womens_handicap_dec_2026 column if not exists
SET @columnname = 'womens_handicap_dec_2026';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' INT NULL')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add created_at column if not exists
SET @columnname = 'created_at';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' TIMESTAMP DEFAULT CURRENT_TIMESTAMP')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add updated_at column if not exists
SET @columnname = 'updated_at';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE ', @tablename, ' ADD COLUMN ', @columnname, ' TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Drop old 'name' column if exists (do this after adding new columns)
SET @columnname = 'name';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE table_name = @tablename AND table_schema = @dbname AND column_name = @columnname) > 0,
  CONCAT('ALTER TABLE ', @tablename, ' DROP COLUMN ', @columnname),
  'SELECT 1'
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Add indexes for better search performance
-- Note: Run these manually if needed, ignoring errors for already existing indexes
-- CREATE INDEX idx_players_first_name ON players(first_name);
-- CREATE INDEX idx_players_surname ON players(surname);
-- CREATE INDEX idx_players_state ON players(state);

-- ============================================
-- 3. INSERT CLUBS (if not already exists)
-- ============================================
INSERT IGNORE INTO clubs (name, location, is_active) VALUES
('Eynesbury Polo Club', 'VIC', TRUE),
('Muddy Flats Polo Club', 'NSW', TRUE),
('Downs Polo Club', 'QLD', TRUE),
('Timor Polo Club', 'NSW', TRUE),
('Ellerston Polo Club', 'NSW', TRUE),
('Serpentine Polo Club', 'WA', TRUE),
('Garangula Polo Club', 'NSW', TRUE),
('South East Queensland Polo Club', 'QLD', TRUE),
('Forbes Polo Club', 'NSW', TRUE),
('Kurri Burri Polo Club', 'NSW', TRUE),
('Scone Polo Club', 'NSW', TRUE),
('Brisbane Polo & Equestrian Club', 'QLD', TRUE),
('Goulburn Polo Club', 'NSW', TRUE),
('Yaloak Polo Club', 'VIC', TRUE),
('Adelaide Polo Club', 'SA', TRUE),
('Windsor Polo Club', 'NSW', TRUE),
('Quirindi Polo Carnival Club', 'NSW', TRUE),
('Hexham Polo Club', 'VIC', TRUE),
('Flat Hill Farm', 'NSW', TRUE),
('Tamarang Polo Club', 'NSW', TRUE),
('Vallex Polo Club', 'VIC', TRUE),
('Noosa Country Polo', 'QLD', TRUE),
('Killarney Polo Club', 'NSW', TRUE),
('North Star Polo Club', 'NSW', TRUE),
('Perth Polo Club', 'WA', TRUE),
('Swan Valley Polo Club', 'WA', TRUE),
('Kojonup Polo and Polocrosse Club', 'WA', TRUE),
('Wirragulla Polo Club', 'NSW', TRUE),
('Town and Country Polo Club', 'NSW', TRUE),
('Millamolong Polo Club', 'NSW', TRUE),
('Yarra Valley Polo Club', 'VIC', TRUE),
('NSW Polo', 'NSW', TRUE),
('Larapinta', 'QLD', TRUE),
('Arunga Polo Club', 'NSW', TRUE),
('Jemalong Polo Club', 'NSW', TRUE),
('Hunters Hill Polo Club', 'QLD', TRUE),
('Mingela Polo Club', 'VIC', TRUE),
('Mudgee Polo Club', 'NSW', TRUE),
('Fultons Lane Polo Club', 'VIC', TRUE);

-- ============================================
-- 4. INSERT PLAYERS - BATCH 1 (A-B)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Robert', 'Abbott', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Victoria', 'Abbott', 'VIC', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Alex', 'Adams', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Mark', 'Adamson', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Augustus', 'Aguirre', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Cole', 'Aguirre', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Mariano', 'Aguirre', 'NSW', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Brett', 'Allan', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Chloe', 'Allen', 'WA', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Dwayne', 'Allen', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Kate', 'Allen', 'WA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Scott', 'Allen', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Damian', 'Allport', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Juan', 'Ambroggio', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Jane', 'Ament', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jacob', 'Amenta', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Paul', 'Angerson', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Orlah', 'Angrove', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Lachie', 'Appleby', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Aisha', 'Arayne', 'VIC', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Edward', 'Archibald', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jack', 'Archibald', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Robert', 'Archibald', 'NSW', 4, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Scott', 'Archibald', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Charles', 'Arthur', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Mike', 'Arthur', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Wallace', 'Ashton', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Henry', 'Bachelor', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Andrew', 'Badgery', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Boo', 'Badgery', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Heidi', 'Badgery', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Harriet', 'Bailey', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Peter', 'Bailey', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Chris', 'Baillieu', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Ruki', 'Baillieu', 'VIC', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Ashley', 'Ball', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Rob', 'Ballard', 'VIC', 4, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Sandra', 'Ballard', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Elizabeth', 'Bannell', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Mark', 'Barber', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Ben', 'Barham', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Geneieve', 'Barker', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Michael', 'Barker', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Sian', 'Barnacle', 'QLD', 1, 5, 1, 5, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Steve', 'Barnard', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Alex', 'Barnet', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Hugh', 'Barnet', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Matthew', 'Barnett', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Jeremy', 'Bayard', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Town and Country Polo Club' LIMIT 1)),
('Jonathan', 'Bayes', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Jessica', 'Beirne', 'QLD', -2, 0, -2, 1, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Simon', 'Beirne', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Digby', 'Bell', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Henry', 'Bell', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Sinclair', 'Bell', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Grant', 'Bennett', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Indiana', 'Bennetto', 'QLD', 1, 5, 1, 5, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jack', 'Berner', 'VIC', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Manna', 'Berry', 'NSW', -1, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Tim', 'Berry', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('McCathur', 'Bettington', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Hannah', 'Billett', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Brendan', 'Blake', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Thomas', 'Blakeley', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Andrew', 'Blattman', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Beau', 'Blundell', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Wirragulla Polo Club' LIMIT 1)),
('Gus', 'Boonzaaier', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Shannon', 'Booth', 'NSW', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Jaime', 'Bourdieu', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Nick', 'Bowen', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Charles', 'Boyd', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Timothy', 'Boyd', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Greg', 'Brabham', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Edward', 'Bradley', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Winston', 'Bradley', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Bill', 'Brawne', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Cameron', 'Brawne', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Michael', 'Bretton', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Andrew', 'Bridson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Amelia', 'Brien', 'VIC', -1, 3, -1, 3, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Jemma', 'Brown', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Jeremy', 'Brown', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Lily', 'Brown', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Greg', 'Browne', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Ray', 'Bruce', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Adam', 'Buchert', 'NSW', 1, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Archer', 'Buchert', 'NSW', -1, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Inge', 'Burke', 'VIC', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('James', 'Burkitt', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Amanda', 'Burns', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Brett', 'Burns', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Jonathan', 'Bush', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jason', 'Butt', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Cameron', 'Byrne', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Rebecca', 'Byrne', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1));

-- ============================================
-- 5. INSERT PLAYERS - BATCH 2 (C)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Sasha', 'Caller', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Michael', 'Callow', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Heidi', 'Calvert-Jones', 'VIC', -2, 0, -1, 0, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Richard', 'Cameron', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Andrew', 'Campbell', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Angus', 'Campbell', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Colin', 'Campbell', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Monty', 'Campbell', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Toby', 'Campbell', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Sandra', 'Carder', 'QLD', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Rodrigo', 'Castrillo', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Flat Hill Farm' LIMIT 1)),
('Rodrigo', 'Castrillo Jr', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Flat Hill Farm' LIMIT 1)),
('Jack', 'Cawdell-Smith', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Scott', 'Chambers', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Angie', 'Chandler', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Alison', 'Charlton', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Crispin', 'Cheadle', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Gretchen', 'Ciapura', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Ollie', 'Clark', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Philip', 'Clark', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Sarah-Jane', 'Clark', 'QLD', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Graeme', 'Clarke', 'VIC', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('John Paul', 'Clarkin', 'QLD', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Adrian', 'Cobley', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Niall', 'Coburn', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Alastair', 'Cochrane', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Alistair', 'Cochrane', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Melanie', 'Cochrane', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Zach', 'Cochrane', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Dominic', 'Cook', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Nikki', 'Cook', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Peter', 'Cooke', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Amy', 'Coombs', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Greg', 'Coops', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Ollie', 'Cork', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Andrew', 'Coulton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('David', 'Coulton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Sam', 'Coulton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Thomas', 'Coulton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Bianca', 'Coventry', 'QLD', 0, 2, 0, 2, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Ben', 'Cowan', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Justin', 'Cowley', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Noah', 'Cox', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('George', 'Cronin', 'NSW', NULL, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Kristy', 'Crook', 'WA', -1, 3, -1, 3, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Angus', 'Crossing', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Ben', 'Crossing', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('George', 'Crouch', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Ollie', 'Cudmore', 'NSW', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Eduardo', 'Cuneo', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Ed', 'Cunningham', 'SA', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Guy', 'Cunningham', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Theodore', 'Cunningham', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Miles', 'Curran', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Richard', 'Curran', 'NSW', 3, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Paul', 'Cutcliffe', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Kristina', 'Czepl', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1));

-- ============================================
-- 6. INSERT PLAYERS - BATCH 3 (D-E)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Danny', 'Daher', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Chris', 'Daily', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Caleb', 'Dales', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Josh', 'Dales', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Tom', 'Dalton-Morgan', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Graham', 'Daniels', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Jake', 'Daniels', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Edward', 'Davidson', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Rob', 'Davies', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Olivia', 'de Govrik', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Barry', 'Deacon', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Jason', 'Denny', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('William', 'Denny', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('George', 'Deverall', 'SA', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Olivia', 'Dixon', 'SA', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Mitch', 'Dollard', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Sam', 'Dollard', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Murray', 'Donnelly', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Geoffery', 'Donovan', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jack', 'Doolin', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Richard', 'Doolin', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Simon', 'Doolin', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Victoria', 'Doolin', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Max', 'Dormer', 'NSW', 0, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Peter', 'Dormer', 'NSW', 1, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Anna', 'Dowling', 'NSW', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Archie', 'Dowling', 'NSW', 1, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Frederica', 'Dowling', 'VIC', -1, 1, -1, 2, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Hamish', 'Dowling', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Jack', 'Dowling', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Olivia', 'Dowling', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Phil', 'Dowling', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Toby', 'Dowling', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Amber', 'Drum', 'VIC', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Eilidh', 'Drummond', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jane', 'Drummond', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Matthew', 'Dunn', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Lana', 'Eastment', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Marie Louise', 'Easton', 'NSW', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Katie', 'Edmeades', 'NSW', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Jake', 'EdnieBrown', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Eleisha', 'Elliot', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Martha', 'Emeney', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'NSW Polo' LIMIT 1)),
('Kirill', 'Eremenko', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Matt', 'Evertts', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1));

-- ============================================
-- 7. INSERT PLAYERS - BATCH 4 (F)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Shane', 'Fagan', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Juan', 'Falcon', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Rohan', 'Fanning', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Tomas', 'Fernandez', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Tomas', 'Fernandez-Llorente', 'NSW', 7, NULL, 7, NULL, (SELECT id FROM clubs WHERE name = 'Jemalong Polo Club' LIMIT 1)),
('Vince', 'Ferraro', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Simone', 'Ferrie', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('James', 'Fewster', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Mark', 'Field', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Shane', 'Finemore', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Hugo', 'Fischer', 'WA', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Imagele', 'Fischer', 'WA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Alex', 'Fisher', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jeff', 'Fisher', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Fredie', 'Fisk', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('John', 'Fitzgerald', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Bingham', 'Fitz-Henry', 'SA', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Michael', 'Fitz-Henry', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Philippa', 'Fitz-Henry', 'QLD', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Robin', 'Fitz-Henry', 'QLD', -2, -1, -2, -1, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Lillie', 'Flanagan', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Callum', 'Fogarty', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Emily', 'Forbes', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Rohan', 'Ford', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Indigo', 'Francis', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Scarlett', 'Francis', 'NSW', -2, 1, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Stirling', 'Francis', 'NSW', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('George', 'Fraser', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Louise', 'Fraser', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Leah', 'Freney', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Faidra Lisa', 'Frey', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Dean', 'Fullerton', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Ferdinand', 'Furch', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1));

-- ============================================
-- 8. INSERT PLAYERS - BATCH 5 (G)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Sam', 'Gairdner', 'VIC', 3, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Anthony', 'Gard', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Tim', 'Garner', 'NSW', -2, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Jarrod', 'Gaudron', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Bruce', 'Gavin', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Andrew', 'Gebbie', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Corin', 'Gibbs', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Myles', 'Gillespie', 'NSW', NULL, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Andy', 'Gilmore', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Angus', 'Gilmore', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Derek', 'Gilmore', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Glen', 'Gilmore', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Jim', 'Gilmore', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'NSW Polo' LIMIT 1)),
('Lachlan', 'Gilmore', 'QLD', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Orry', 'Gilmore', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Pip', 'Gilmore', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Skye', 'Gilmore', 'NSW', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Will', 'Gilmore', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Daniel', 'Gilshenan', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Keenya', 'Giroux-Harries', 'VIC', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Ashley', 'Glennie', 'NSW', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Wayne', 'Glennie', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Eleanor', 'Glissan', 'NSW', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Peter', 'Gold', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Toby', 'Goodman', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Ed', 'Goold', 'VIC', 2, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Dirk', 'Gould', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Virginia', 'Graham', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('John', 'Grant', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Brad', 'Greene', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Karlie', 'Greenland', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Mark', 'Greig', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Andrew', 'Greuter', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Alisha', 'Griffiths', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Blake', 'Grimes', 'NSW', 2, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Cody', 'Grimes', 'NSW', 3, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Jack', 'Grimes', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Lucas', 'Grimes', 'NSW', 1, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Matt', 'Grimes', 'NSW', 4, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Peter', 'Grimes', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Katie', 'Grimmond', 'QLD', 0, 3, 0, 2, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Amy', 'Gunn', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Angus', 'Gunn', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Sam', 'Gunn', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Luke', 'Gunning', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1));

-- ============================================
-- 9. INSERT PLAYERS - BATCH 6 (H)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Isaac', 'Hagedoorn', 'WA', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Jess', 'Hagedoorn', 'WA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Lucy', 'Hagedoorn', 'WA', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Ivan', 'Haggerty', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('James', 'Hailstone', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Alex', 'Hamilton', 'NSW', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Peter', 'Handbury', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Campbell', 'Hanson', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('James', 'Harper', 'NSW', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Wills', 'Harper', 'NSW', 5, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Drew', 'Harris', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Hannah', 'Harris', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Stewart', 'Hawkins', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('David', 'Head', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Harry', 'Head', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Jim', 'Head', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Mitchell', 'Hearn', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('James', 'Henry', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Paul', 'Henschke', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('David', 'Henwood', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Justine', 'Henwood', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Earl', 'Herbert', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Archie', 'Heseltine', 'NSW', NULL, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Guy', 'Higginson', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('George', 'Hill', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Josh', 'Hill', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Joshua', 'Hill', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Simon', 'Hill', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Edward', 'Hitchman', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('James', 'Hockey', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Pip', 'Hodson', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Gary', 'Hoey', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('James', 'Hoey', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Mark', 'Hoey', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Stuart', 'Hoey', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Craig', 'Holman', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Noah', 'Holuigue', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Georgia', 'Hopkins', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Sam', 'Hopkinson', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Mark', 'Huebner', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Adam', 'Humphreys', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Emily', 'Humphreys', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Sam', 'Hunt', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Tom', 'Hunt', 'QLD', 5, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Jaime', 'Hurley', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Peter', 'Huston', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Alfie', 'Hyde', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1));

-- ============================================
-- 10. INSERT PLAYERS - BATCH 7 (I-J)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Marty', 'Ingham', 'SA', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Balfour', 'Irvine', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jess', 'Irvine', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Kate', 'Irvine', 'QLD', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Mike', 'Irvine', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Sebastian', 'Isgro', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Barry', 'Jackson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Casey', 'Jackson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Liam', 'Jackson', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Aurelie', 'Jaffres', 'VIC', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Vedansh', 'Jaiswal', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Simone', 'James', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Amanda', 'Jarvis', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Matt', 'Jarvis', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Anthony', 'Johnson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Kelvin', 'Johnson', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Zachary', 'Johnson', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Chad', 'Johnston', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Damien', 'Johnston', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Gary', 'Johnston', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Louis', 'Johnston', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Annie', 'Jones', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Ben', 'Jones', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Charlie', 'Jones', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Chloe', 'Jones', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Dylan', 'Jones', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1));

-- ============================================
-- 11. INSERT PLAYERS - BATCH 8 (K)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Colt', 'Kahlbetzer', 'NSW', 0, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Jemalong Polo Club' LIMIT 1)),
('John', 'Kahlbetzer', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Jemalong Polo Club' LIMIT 1)),
('Steve', 'Kapernick', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Clare', 'Katavich', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Ben', 'Kavanagh', 'VIC', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Benjamin', 'Kay', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Mingela Polo Club' LIMIT 1)),
('Will', 'Keen', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Tom', 'Keightley', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Oscar', 'Kelly', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Phil', 'Kelly', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Scott', 'Kennedy-Green', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Mudgee Polo Club' LIMIT 1)),
('Sam', 'Kenny', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Mark', 'Kent', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Gregory', 'Keyte', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Kelly', 'Keyte', 'VIC', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Nick', 'Keyte', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Zachary', 'Keyte', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Agha', 'Khan', 'WA', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Gavin', 'Kidd', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Brett', 'Kiely', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Daniel', 'Kilmartin', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Luke', 'Kilmartin', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Matthew', 'Kilmartin', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Michael', 'King', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jennifer', 'Kinsella', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Killian', 'Kinsella', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Annalise', 'Kloe', 'VIC', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Samantha', 'Kloe', 'VIC', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1));

-- ============================================
-- 12. INSERT PLAYERS - BATCH 9 (L)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Julian', 'Lancia', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Raul', 'Laplacette', 'NSW', 7, NULL, 7, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Nigel', 'Larritt', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Jemma', 'Lawerence', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Marty', 'Leacy', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Lauchlan', 'Leishman', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('AJ', 'Lester', 'WA', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('James', 'Lester', 'WA', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Holly', 'Lewis', 'SA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Gabriel', 'Li', 'NSW', NULL, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Mark', 'Lillyman', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Mark', 'Lindh', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Matt', 'Lindh', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Morgan', 'Lindh', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Andrew', 'Littleford', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Facundo', 'Llamacares', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Eduardo', 'Lopez', 'NSW', 0, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Brigitte', 'Low', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Jack', 'Luxford', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Roger', 'Lynch', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Jennifer', 'Lyons-Negus', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1));

-- ============================================
-- 13. INSERT PLAYERS - BATCH 10 (M - part 1)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('William', 'Macdonald', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Paul', 'MacGinley', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Hector', 'Macintyre', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jock', 'Mackay', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Wirragulla Polo Club' LIMIT 1)),
('Iyan', 'Mackenzie', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Genny', 'Mackenzie-Hammond', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('John', 'MacKinnon', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Jock', 'MacLachlan', 'SA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Will', 'Maginness', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Ainslie', 'Maher', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Ben', 'Malden', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Nick', 'Male', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Edward', 'Mandie', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Graham', 'Mann', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Jack', 'Mantova', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Richard', 'Marchant', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Bridgett', 'Maritz', 'SA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Jeremy', 'Marriott', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Tudor', 'Marsden-Huggins', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Adam', 'Marshall', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('David', 'Marshall', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Elisha', 'Marshall', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Harrison', 'Marshall', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Jackson', 'Marshall', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('James', 'Marshall', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('John', 'Marshall', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Jessica', 'Martin', 'NSW', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Peter', 'Martin', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Shane', 'Martin', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Thomas', 'Martin', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Billie', 'Mascart', 'NSW', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Bruno', 'Mascart', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Enzo', 'Mascart', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Justin', 'Mathews', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Chris', 'Matthews', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Emma', 'Matthews', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Edward', 'Matthies', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Troy', 'McBean', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Ric', 'McCarthy', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Clare', 'McCormack', 'NSW', NULL, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Alan', 'McCormack', 'NSW', NULL, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Siobhan', 'McCray', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Scott', 'McCreery', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Kimberley', 'McDougall', 'NSW', -1, 0, -1, 0, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Kate', 'McGavin', 'VIC', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Angus', 'MCGregor', 'NSW', NULL, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Hamish', 'McGregor', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Lachlan', 'McGregor', 'NSW', NULL, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Monty', 'McGregor', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Ranald', 'McGregor', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Stirling', 'McGregor', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Thyne', 'McGregor', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Fern', 'McIldowie', 'QLD', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Hamish', 'McIntosh', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Julie', 'Mcintosh', 'NSW', -1, 3, -1, 3, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Olivia DuBois', 'McIntosh', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Gillon', 'Mclachlan', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Deanne', 'Mclellan', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Scot', 'Mclellan', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Bryce', 'McMurtrie', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Kathryn', 'McNee', 'WA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Adam', 'Meally', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Pablo', 'Menchaca', 'NSW', NULL, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Brendan', 'Menegazzo', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Hugh', 'Menegazzo', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jaymond', 'Menegazzo', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Coco', 'Merz', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Paul', 'Metcalf', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Jack', 'Milbank', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Alex', 'Miller', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Chloe', 'Miller', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Joshua', 'Miller', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Layla', 'Miller', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Jim', 'Mitchell', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Jock', 'Mitchell', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Jock', 'Mitchell Jnr', 'VIC', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Lachlan', 'Molesworth', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Alan', 'Moore', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Tomas', 'Moreno', 'QLD', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Max', 'Morgan', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Robert', 'Morran', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Amelia', 'Morton', 'NSW', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Kate', 'Moss', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'NSW Polo' LIMIT 1)),
('Barry', 'Moule', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Lucy', 'Moule', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Cormac', 'Mulcahy', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Doug', 'Munro', 'NSW', 2, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Billy', 'Murfitt', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Teneille', 'Murray', 'NSW', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1));

-- ============================================
-- 14. INSERT PLAYERS - BATCH 11 (N-O)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Joolz', 'Nassir', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Annabelle', 'Nesham', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Amanda', 'Norton-Knight', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('E', 'Novillo', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Aiden', 'Nunn', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Augustin', 'Odasso', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Shane', 'ODonnell', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Patrick', 'ODwyer', 'NSW', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Tim', 'Olden', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Anthony', 'OLeary', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Anthony George', 'OLeary', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Anthony Max', 'OLeary', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Daniel', 'Oleary', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Haydn', 'OLeary', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Zachary', 'OLeary', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Angus', 'Onisforou', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Declan', 'ORourke', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Erin', 'ORourke', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Shaun', 'ORourke', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Ben', 'Osborne', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Katrina', 'Osborne', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Quirindi Polo Carnival Club' LIMIT 1)),
('Serena', 'Osborne', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Alejandro', 'Otamendi', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Kirstie', 'Otamendi', 'WA', 1, 5, 1, 5, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1));

-- ============================================
-- 15. INSERT PLAYERS - BATCH 12 (P)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Bautista', 'Panelo', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('David', 'Paradice', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Fiona', 'Parfoot', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Hugh', 'Parry-Okeden', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Flat Hill Farm' LIMIT 1)),
('James', 'Parry-Okeden', 'NSW', 1, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Flat Hill Farm' LIMIT 1)),
('Tom', 'Parry-Okeden', 'NSW', 0, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Flat Hill Farm' LIMIT 1)),
('Olivia', 'Paterson', 'NSW', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Angus', 'Payne', 'NSW', NULL, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jamie', 'Payne', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Katherine', 'Pedersen', 'QLD', -1, 0, -1, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Federico', 'Perrera', 'NSW', NULL, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Matt', 'Perry', 'NSW', 6, NULL, 6, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Harriet', 'Peters', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('George', 'Philip', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Robert', 'Pitts', 'VIC', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Cate', 'Plumber', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Lee', 'Portelli', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Katie', 'Porteous', 'QLD', 0, 2, 0, 3, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('John', 'Prendiville', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Samuel', 'Prendiville', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Warwick', 'Prendiville', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Alison', 'Prentice', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Roger', 'Priest', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Town and Country Polo Club' LIMIT 1));

-- ============================================
-- 16. INSERT PLAYERS - BATCH 13 (R)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Troy', 'Rabaud', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Olivia', 'Raeburn', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Isla', 'Railton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Peta Gay', 'Railton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Rowena', 'Rainger', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Eliot', 'Ralph', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Jack', 'Raval', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Jack', 'Rawlings', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('James', 'Rawlings', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Sam', 'Rawlings', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Tom', 'Rawlings', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Jessica', 'Rea', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Zoe', 'Reader', 'NSW', NULL, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Blake', 'Reid', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Elizabeth', 'Reid', 'WA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('James', 'Reid', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Joanne', 'Reid', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Luke', 'Reid', 'WA', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Harry', 'Revell', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Luke', 'Reynolds', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Alex', 'Rigby', 'QLD', -1, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Beltran', 'Riglos', 'NSW', NULL, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Jemalong Polo Club' LIMIT 1)),
('Jose', 'Riglos', 'NSW', 6, NULL, 7, NULL, (SELECT id FROM clubs WHERE name = 'Jemalong Polo Club' LIMIT 1)),
('Lautro', 'Ripamonti', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('Michael', 'Roberts', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Nico', 'Roberts', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Sam', 'Robson', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Bonnie', 'Rodwell', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Greg', 'Rodwell', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Peter', 'Rodwell', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Harry', 'Rogers', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Joel', 'Rogers', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Lucas', 'Rogers', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Thomas', 'Rogers', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Victoria', 'Rose', 'VIC', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Justin', 'Rous', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Kelsey', 'Rowland', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Luke', 'Rowley', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Jasmine', 'Rozing', 'QLD', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Lilian', 'Rudd', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Morgan', 'Ruig', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Augustin', 'Ruiz', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Santiago', 'Ruiz', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Nicholas', 'Ruiz Guinzeau', 'NSW', 3, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Alessia', 'Russo', 'QLD', 0, 4, 0, 4, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Angelo', 'Russo', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Louisa', 'Ryan', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Shane', 'Ryan', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1));

-- ============================================
-- 17. INSERT PLAYERS - BATCH 14 (S)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Antonio', 'Saavedra m', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Betty', 'Samadi', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Harriet', 'Sanderson-Baker', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Jack', 'Sanderson-Baker', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Molly', 'Sanderson-Baker', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Haley', 'Schaufeld', 'WA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Guy', 'Schwarzenbach', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Garangula Polo Club' LIMIT 1)),
('Hannah', 'Scolaro', 'WA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Emma', 'Scott', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Jonathan', 'Scott', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Arman', 'Selehirad', 'NSW', NULL, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Jake', 'Shaw', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Luke', 'Shelbourne', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Fultons Lane Polo Club' LIMIT 1)),
('Ben', 'Shepard', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('James', 'Shepard', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'North Star Polo Club' LIMIT 1)),
('Jessica', 'Sheppard', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Lance', 'Sheppard', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Maddie', 'Shoesmith', 'SA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Richard', 'Shoesmith', 'SA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Adam', 'Sims', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Alan', 'Simson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('William', 'Simson', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Geoff', 'Sinclair', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Yarra Valley Polo Club' LIMIT 1)),
('Abhay', 'Singh', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Marhiraj', 'Singh', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Beau', 'Skerrett', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Simon', 'Skerrett', 'QLD', 0, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Alexandra', 'Slack', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Christopher', 'Slack', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Katrina', 'Slack', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Brisbane Polo & Equestrian Club' LIMIT 1)),
('Drew', 'Slack-Smith', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Luisa', 'Slack-Smith', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('William', 'Slater', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Luke', 'Smallman', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Sam', 'Smallman', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Daren', 'Smith', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Kirrily', 'Smith', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Ollie', 'Snart', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Charlie', 'Sommerville', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Gordon', 'Sorby', 'QLD', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Ebony', 'Spence', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Jack', 'Spillsbury', 'QLD', 3, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Charlie', 'Spilsbury', 'NSW', NULL, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Alan', 'Stafford', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Madeline', 'Stark', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Reuben', 'Steer', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Neville', 'Stewart', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Tim', 'Stewart', 'VIC', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Justin', 'Still', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Brooke', 'Stilla', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Scarlett', 'Storie', 'NSW', -2, 1, -1, NULL, (SELECT id FROM clubs WHERE name = 'Kurri Burri Polo Club' LIMIT 1)),
('Sam', 'Stott', 'VIC', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('Harriet', 'Stratton', 'NSW', NULL, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Sinclair', 'Stratton', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Sophie', 'Stratton', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Michael', 'Strauss', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Declean', 'Sullivan', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Mark', 'Swanepoel', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1));

-- ============================================
-- 18. INSERT PLAYERS - BATCH 15 (T)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Angus', 'Taylor', 'QLD', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Bill', 'Taylor', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Craig', 'Taylor', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Jack', 'Taylor', 'QLD', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Miechelle', 'Taylor', 'SA', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Sharlene', 'Telford', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Tony', 'Telford', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Leo', 'Tharby', 'VIC', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Fletcher', 'Thew', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Ed', 'Thirlwall', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Oliver', 'Thirlwall', 'NSW', -2, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Archie', 'Thomas', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('BJ', 'Thomas', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Swan Valley Polo Club' LIMIT 1)),
('James', 'Thomas', 'VIC', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Marijke', 'Thomas', 'WA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Kojonup Polo and Polocrosse Club' LIMIT 1)),
('Benita', 'Thompson', 'VIC', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Yaloak Polo Club' LIMIT 1)),
('Samantha', 'Thompson', 'NSW', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Tamarang Polo Club' LIMIT 1)),
('Harry', 'Thomson', 'QLD', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Ben', 'Tiplady', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Adam', 'Tolhurst', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Mark', 'Tolhurst', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Arunga Polo Club' LIMIT 1)),
('Matt', 'Tomlinson', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Fran', 'Townend', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Brooke', 'Trethowan', 'WA', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Pete', 'Trethowan', 'WA', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Perth Polo Club' LIMIT 1)),
('Paul', 'Trickett', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Piper', 'Trickett', 'NSW', 0, 1, 0, 1, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Carlie', 'Trotter', 'VIC', -1, 3, -1, 3, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Lilly', 'Tuesley', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Tom', 'Turner', 'NSW', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1));

-- ============================================
-- 19. INSERT PLAYERS - BATCH 16 (U-W)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Lily', 'Urquhart', 'QLD', -2, 0, -1, 1, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Steve', 'Urquhart', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Mateo', 'Ussher', 'VIC', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Eynesbury Polo Club' LIMIT 1)),
('Hayley', 'Uttley', 'VIC', -2, 1, -2, 1, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Sophie', 'Utz', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Timor Polo Club' LIMIT 1)),
('Steve', 'Van Den Brink', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Jason', 'Varker Miles', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Wendy', 'Waddell', 'VIC', -1, 2, -1, 2, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Trent', 'Walkden', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Rebecca', 'Walters', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Ronald', 'Wanless', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Alexander', 'Warner', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Matt', 'Warner', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('William', 'Warner', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Chloe', 'Warren', 'SA', 1, 4, 1, 4, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Byron', 'Watson', 'VIC', 5, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('John', 'Watson', 'SA', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Kaleb', 'Watson', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Nick', 'Wayland', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Juliette', 'Webber', 'NSW', -1, 1, -1, 1, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Paddy', 'Webber', 'NSW', NULL, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jasper', 'Webster', 'WA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Tex', 'Webster', 'WA', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Mark', 'Welch', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Will', 'Wennerbom', 'NSW', -1, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Millamolong Polo Club' LIMIT 1)),
('Erin', 'Wheatley', 'WA', 0, 3, 0, 3, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Alec', 'White', 'NSW', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Anto', 'White', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Jasper', 'White', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Dougal', 'Whyte', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Hunters Hill Polo Club' LIMIT 1)),
('Gus', 'Whyte', 'SA', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Adelaide Polo Club' LIMIT 1)),
('Emma', 'Wilkinson', 'QLD', -2, 0, -2, 0, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Tomas', 'Willans', 'NSW', 5, NULL, 5, NULL, (SELECT id FROM clubs WHERE name = 'Ellerston Polo Club' LIMIT 1)),
('Andrew', 'Williams', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Guthrie', 'Williamson', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Sam', 'Willis', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Nick', 'Wills', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Cameron', 'Wilson', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Scone Polo Club' LIMIT 1)),
('Craig', 'Wilson', 'QLD', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Downs Polo Club' LIMIT 1)),
('Daz', 'Wilson', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Noosa Country Polo' LIMIT 1)),
('Bayden', 'Winfield', 'WA', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Serpentine Polo Club' LIMIT 1)),
('Ian', 'Wingrove', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Muddy Flats Polo Club' LIMIT 1)),
('Curtis', 'Winwood', 'QLD', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1)),
('Clive', 'Withinshaw', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Charlie', 'Wood', 'NSW', 3, NULL, 3, NULL, (SELECT id FROM clubs WHERE name = 'Town and Country Polo Club' LIMIT 1)),
('Jimmy', 'Wood', 'VIC', 4, NULL, 4, NULL, (SELECT id FROM clubs WHERE name = 'Vallex Polo Club' LIMIT 1)),
('James', 'Worker', 'QLD', 2, NULL, 2, NULL, (SELECT id FROM clubs WHERE name = 'Larapinta' LIMIT 1)),
('Felicity', 'Worland', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Tess', 'Worland', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Forbes Polo Club' LIMIT 1)),
('Glen', 'Wright', 'QLD', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'South East Queensland Polo Club' LIMIT 1));

-- ============================================
-- 20. INSERT PLAYERS - BATCH 17 (X-Z)
-- ============================================
INSERT INTO players (first_name, surname, state, handicap_jun_2025, womens_handicap_jun_2025, handicap_dec_2026, womens_handicap_dec_2026, club_id) VALUES
('Ben', 'Yates', 'NSW', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Goulburn Polo Club' LIMIT 1)),
('Arthur', 'Yencken', 'VIC', -1, NULL, -1, NULL, (SELECT id FROM clubs WHERE name = 'Hexham Polo Club' LIMIT 1)),
('Alex', 'Zak', 'NSW', 0, NULL, 0, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Tammy', 'Zak', 'NSW', -2, NULL, -2, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1)),
('Julian', 'Zapico', 'NSW', 1, NULL, 1, NULL, (SELECT id FROM clubs WHERE name = 'Windsor Polo Club' LIMIT 1)),
('Juan Martin', 'Zavaleta', 'NSW', 7, NULL, 7, NULL, (SELECT id FROM clubs WHERE name = 'Killarney Polo Club' LIMIT 1));

-- ============================================
-- MIGRATION COMPLETE
-- ============================================
SELECT 'Player handicap migration complete!' AS status
