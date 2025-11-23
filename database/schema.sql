-- ============================================================================
-- Australian Polo Backend - Database Schema
-- MySQL/AWS RDS Compatible
-- ============================================================================

-- Drop existing tables (if needed for fresh install)
-- Uncomment the lines below if you want to drop existing tables
-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE IF EXISTS awards;
-- DROP TABLE IF EXISTS rosters;
-- DROP TABLE IF EXISTS matches;
-- DROP TABLE IF EXISTS horses;
-- DROP TABLE IF EXISTS players;
-- DROP TABLE IF EXISTS teams;
-- DROP TABLE IF EXISTS breeders;
-- DROP TABLE IF EXISTS tournaments;
-- DROP TABLE IF EXISTS users;
-- SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================================
-- 1. USERS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'bcrypt hashed password',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 2. TOURNAMENTS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS tournaments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    location VARCHAR(200) NOT NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_location (location),
    INDEX idx_dates (start_date, end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 3. TEAMS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    coach VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 4. BREEDERS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS breeders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 5. PLAYERS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    team_id INT NULL,
    position VARCHAR(50) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_team (team_id),
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 6. HORSES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS horses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    pedigree JSON NULL COMMENT 'JSON object containing pedigree information',
    breeder_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_breeder (breeder_id),
    FOREIGN KEY (breeder_id) REFERENCES breeders(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 7. MATCHES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tournament_id INT NOT NULL,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    scheduled_time DATETIME NULL,
    result VARCHAR(255) NULL COMMENT 'Match result (e.g., "10-8" or "Team1 wins")',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tournament (tournament_id),
    INDEX idx_teams (team1_id, team2_id),
    INDEX idx_scheduled_time (scheduled_time),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (team1_id) REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (team2_id) REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 8. AWARDS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS awards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NULL,
    entity_type ENUM('player', 'team', 'horse') NOT NULL COMMENT 'Type of entity receiving award',
    entity_id INT NULL COMMENT 'ID of the player, team, or horse',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_entity (entity_type, entity_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 9. ROSTERS TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS rosters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_id INT NULL,
    player_id INT NULL,
    tournament_id INT NULL,
    role VARCHAR(100) NULL COMMENT 'Player role in the roster',
    jersey_number INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_team (team_id),
    INDEX idx_player (player_id),
    INDEX idx_tournament (tournament_id),
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================================================

-- Sample Tournament
INSERT INTO tournaments (name, location, start_date, end_date) VALUES
('Australian Open Polo Championship 2025', 'Sydney', '2025-01-15', '2025-01-20');

-- Sample Teams
INSERT INTO teams (name, coach) VALUES
('Sydney Polo Club', 'John Smith'),
('Melbourne Thunder', 'Sarah Johnson'),
('Brisbane Lightning', 'Michael Chen');

-- Sample Players
INSERT INTO players (name, team_id, position) VALUES
('Alex Johnson', 1, 'Forward'),
('Emma Davis', 1, 'Midfielder'),
('James Wilson', 2, 'Defense'),
('Olivia Brown', 2, 'Forward'),
('Liam Taylor', 3, 'Goalkeeper');

-- Sample Breeders
INSERT INTO breeders (name, contact_info) VALUES
('Heritage Polo Horses', 'contact@heritagepolohorses.com'),
('Elite Equine Breeders', '+61 2 9876 5432');

-- Sample Horses
INSERT INTO horses (name, pedigree, breeder_id) VALUES
('Thunder Strike', '{"sire": "Lightning Bolt", "dam": "Storm Queen", "bloodline": "Thoroughbred"}', 1),
('Silver Arrow', '{"sire": "Golden Flash", "dam": "Silver Star", "bloodline": "Arabian"}', 2);

-- Sample Match
INSERT INTO matches (tournament_id, team1_id, team2_id, scheduled_time, result) VALUES
(1, 1, 2, '2025-01-15 14:00:00', NULL);

-- Sample Award
INSERT INTO awards (title, description, entity_type, entity_id) VALUES
('Best Player 2024', 'Outstanding performance throughout the season', 'player', 1),
('Championship Winner', 'Winner of the 2024 Australian Championship', 'team', 1);

-- Sample Roster
INSERT INTO rosters (team_id, player_id, tournament_id, role, jersey_number) VALUES
(1, 1, 1, 'Starting Forward', 10),
(1, 2, 1, 'Starting Midfielder', 8);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check all tables were created
SHOW TABLES;

-- Check table structures
DESCRIBE users;
DESCRIBE tournaments;
DESCRIBE teams;
DESCRIBE breeders;
DESCRIBE players;
DESCRIBE horses;
DESCRIBE matches;
DESCRIBE awards;
DESCRIBE rosters;

-- Count records in each table
SELECT 'users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'tournaments', COUNT(*) FROM tournaments
UNION ALL
SELECT 'teams', COUNT(*) FROM teams
UNION ALL
SELECT 'breeders', COUNT(*) FROM breeders
UNION ALL
SELECT 'players', COUNT(*) FROM players
UNION ALL
SELECT 'horses', COUNT(*) FROM horses
UNION ALL
SELECT 'matches', COUNT(*) FROM matches
UNION ALL
SELECT 'awards', COUNT(*) FROM awards
UNION ALL
SELECT 'rosters', COUNT(*) FROM rosters;
