# Database Setup for AWS RDS

This directory contains all the database schema files needed to set up your Australian Polo Backend on AWS RDS MySQL.

## Files

- **schema.sql** - Complete database schema with all tables and sample data

## Quick Setup Guide

### 1. Connect to Your AWS RDS Instance

```bash
mysql -h aup-db-test-01.cpgo2ia2wuo1.ap-southeast-2.rds.amazonaws.com \
  -P 3306 \
  -u root \
  -p aupolo
```

### 2. Run the Schema Script

```bash
mysql -h aup-db-test-01.cpgo2ia2wuo1.ap-southeast-2.rds.amazonaws.com \
  -P 3306 \
  -u root \
  -p aupolo < database/schema.sql
```

### 3. Verify Installation

Connect to your database and run:

```sql
-- Show all tables
SHOW TABLES;

-- Verify table structures
DESCRIBE users;
DESCRIBE tournaments;

-- Check sample data
SELECT COUNT(*) as total_tables FROM information_schema.tables
WHERE table_schema = 'aupolo';
```

## Database Tables

### 1. users
Authentication and user management
- **Fields**: id, name, email, password, created_at, updated_at
- **Indexes**: email (unique)

### 2. tournaments
Tournament information
- **Fields**: id, name, location, start_date, end_date, created_at, updated_at
- **Indexes**: name, location, dates

### 3. teams
Team information
- **Fields**: id, name, coach, created_at, updated_at
- **Indexes**: name

### 4. breeders
Horse breeder information
- **Fields**: id, name, contact_info, created_at, updated_at
- **Indexes**: name

### 5. players
Player information
- **Fields**: id, name, team_id, position, created_at, updated_at
- **Indexes**: name, team_id
- **Foreign Keys**: team_id → teams(id)

### 6. horses
Horse information with pedigree
- **Fields**: id, name, pedigree (JSON), breeder_id, created_at, updated_at
- **Indexes**: name, breeder_id
- **Foreign Keys**: breeder_id → breeders(id)

### 7. matches
Match information
- **Fields**: id, tournament_id, team1_id, team2_id, scheduled_time, result, created_at, updated_at
- **Indexes**: tournament_id, teams, scheduled_time
- **Foreign Keys**:
  - tournament_id → tournaments(id)
  - team1_id → teams(id)
  - team2_id → teams(id)

### 8. awards
Award information
- **Fields**: id, title, description, entity_type (ENUM), entity_id, created_at, updated_at
- **Indexes**: title, entity
- **Note**: entity_type can be 'player', 'team', or 'horse'

### 9. rosters
Team rosters for tournaments
- **Fields**: id, team_id, player_id, tournament_id, role, jersey_number, created_at, updated_at
- **Indexes**: team_id, player_id, tournament_id
- **Foreign Keys**:
  - team_id → teams(id)
  - player_id → players(id)
  - tournament_id → tournaments(id)

## Foreign Key Relationships

```
tournaments
    ↓
matches (tournament_id)
rosters (tournament_id)

teams
    ↓
players (team_id)
matches (team1_id, team2_id)
rosters (team_id)

breeders
    ↓
horses (breeder_id)

players
    ↓
rosters (player_id)
```

## AWS RDS Configuration

### Security Group Settings

Ensure your RDS security group allows:
- **Inbound**: MySQL/Aurora (3306) from your application server IP
- **Outbound**: All traffic

### Parameter Group Settings

Recommended settings:
- **character_set_server**: utf8mb4
- **collation_server**: utf8mb4_unicode_ci
- **time_zone**: UTC
- **max_connections**: 100 (adjust based on your needs)

### SSL/TLS Configuration

Your backend is configured to use SSL for RDS connections. Ensure:
1. `DB_SSL=true` in your `.env` file
2. Download the RDS CA certificate if needed

## Sample Data

The schema includes sample data for testing:
- 1 tournament
- 3 teams
- 5 players
- 2 breeders
- 2 horses
- 1 match
- 2 awards
- 2 roster entries

To skip sample data, remove the "SAMPLE DATA" section before running the script.

## Backup and Restore

### Create Backup
```bash
mysqldump -h your-rds-endpoint.rds.amazonaws.com \
  -u root -p aupolo > backup_$(date +%Y%m%d).sql
```

### Restore Backup
```bash
mysql -h your-rds-endpoint.rds.amazonaws.com \
  -u root -p aupolo < backup_20250123.sql
```

## Migrations

For future schema changes, create migration files in this directory:
- `migration_001_add_user_roles.sql`
- `migration_002_add_match_scores.sql`
- etc.

## Troubleshooting

### Connection Issues

If you can't connect:
1. Check security group rules
2. Verify RDS instance is publicly accessible (if needed)
3. Confirm credentials in `.env` file
4. Check VPC and subnet configuration

### SSL Connection Issues

If SSL connection fails:
```bash
# Download RDS CA certificate
wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

# Update your connection to use it
mysql --ssl-ca=global-bundle.pem -h your-endpoint ...
```

### Character Set Issues

If you see encoding problems:
```sql
ALTER DATABASE aupolo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## Performance Optimization

### Indexes

All frequently queried columns have indexes:
- User email (unique)
- Tournament name, location
- Team name
- Player name
- Horse name
- Match tournament_id and teams

### Query Optimization

For better performance:
1. Use EXPLAIN to analyze slow queries
2. Add indexes for frequently filtered columns
3. Consider read replicas for high traffic
4. Enable query cache if appropriate

## Monitoring

Monitor these metrics in AWS CloudWatch:
- DatabaseConnections
- CPUUtilization
- FreeableMemory
- ReadLatency / WriteLatency
- DiskQueueDepth

## Cost Optimization

- Use appropriate instance size (start with db.t3.micro for testing)
- Enable automated backups (7-day retention recommended)
- Set up Multi-AZ for production
- Consider Reserved Instances for production use

## Support

For issues with the schema or database setup:
1. Check the application logs in `logs/` directory
2. Test database connectivity with `/health/db` endpoint
3. Review RDS logs in AWS Console
4. Check the CHANGELOG.md for recent changes
