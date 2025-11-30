# Deployment Instructions for Clubs, Fields, and Duties APIs

This document provides step-by-step instructions for deploying the new Clubs, Fields, and Duties APIs to your backend.

## Files Created

### Models
- `models/club.model.js` - Club database operations
- `models/field.model.js` - Field database operations
- `models/duty.model.js` - Duty database operations

### Controllers
- `controllers/club.controller.js` - Club business logic
- `controllers/field.controller.js` - Field business logic
- `controllers/duty.controller.js` - Duty business logic

### Validators
- `validators/club.validator.js` - Club input validation
- `validators/field.validator.js` - Field input validation
- `validators/duty.validator.js` - Duty input validation

### Routes
- `routes/club.routes.js` - Club API endpoints
- `routes/field.routes.js` - Field API endpoints
- `routes/duty.routes.js` - Duty API endpoints

### Database
- `migrations_clubs_fields_duties.sql` - Database migration script

### Modified Files
- `server.js` - Registered new routes

## Deployment Steps

### 1. Database Migration

Run the SQL migration script on your MySQL database:

```bash
# Option 1: Using mysql command line
mysql -u your_username -p your_database_name < migrations_clubs_fields_duties.sql

# Option 2: Using MySQL Workbench or similar GUI
# Simply open and execute migrations_clubs_fields_duties.sql
```

**Important Notes:**
- The script uses `CREATE TABLE IF NOT EXISTS` so it's safe to run multiple times
- The script checks if columns exist before adding foreign keys to existing tables
- Make sure to backup your database before running migrations

### 2. Test Locally

Before deploying to production, test the APIs locally:

```bash
# Install dependencies (if any new ones)
npm install

# Run the server locally
npm start

# Server should start on http://localhost:3000 (or your configured port)
```

### 3. Test the New Endpoints

Use a tool like Postman or curl to test:

**Clubs:**
- GET `/api/clubs` - List all clubs
- GET `/api/clubs/:id` - Get specific club
- POST `/api/clubs` - Create new club
- PUT `/api/clubs/:id` - Update club
- DELETE `/api/clubs/:id` - Delete club

**Fields:**
- GET `/api/fields` - List all fields
- GET `/api/fields/:id` - Get specific field
- POST `/api/fields` - Create new field
- PUT `/api/fields/:id` - Update field
- DELETE `/api/fields/:id` - Delete field

**Duties:**
- GET `/api/duties` - List all duties
- GET `/api/duties/:id` - Get specific duty
- GET `/api/duties/player/:playerId` - Get duties by player
- GET `/api/duties/match/:matchId` - Get duties by match
- POST `/api/duties` - Create new duty
- PUT `/api/duties/:id` - Update duty
- DELETE `/api/duties/:id` - Delete duty

Example curl commands:

```bash
# Create a club
curl -X POST http://localhost:3000/api/clubs \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Melbourne Polo Club",
    "location": "Melbourne, VIC",
    "founded_date": "2020-01-15"
  }'

# Create a field
curl -X POST http://localhost:3000/api/fields \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Main Field",
    "location": "Sydney",
    "grade": "High Goal"
  }'

# Create a duty
curl -X POST http://localhost:3000/api/duties \
  -H "Content-Type: application/json" \
  -d '{
    "type": "Umpire",
    "date": "2025-12-01T14:00:00",
    "notes": "Finals match",
    "player_id": 1,
    "match_id": 5
  }'
```

### 4. Deploy to AWS (EC2)

If you're deploying to AWS EC2:

```bash
# 1. SSH into your EC2 instance
ssh -i your-key.pem ec2-user@your-ec2-ip

# 2. Navigate to your backend directory
cd /path/to/Australian-Polo-Backend

# 3. Pull the latest code
git pull origin main

# 4. Install any new dependencies
npm install

# 5. Run the database migration
mysql -u your_db_user -p your_db_name < migrations_clubs_fields_duties.sql

# 6. Restart the application (adjust based on your setup)
# If using PM2:
pm2 restart all

# If using systemd:
sudo systemctl restart your-app-name

# If running directly with node:
# Stop the current process and restart
node server.js
```

### 5. Verify Production Deployment

Test the endpoints on your production server:

```bash
# Replace with your actual server URL
curl https://your-api-domain.com/api/clubs
curl https://your-api-domain.com/api/fields
curl https://your-api-domain.com/api/duties
```

### 6. API Documentation

The new endpoints are automatically included in your Swagger documentation at:
```
http://your-server:3000/api-docs
```

Visit this URL to see interactive API documentation.

## Request/Response Examples

### Club

**Create Club Request:**
```json
{
  "name": "Sydney Polo Club",
  "location": "Sydney, NSW",
  "founded_date": "2015-06-20"
}
```

**Response:**
```json
{
  "id": 1,
  "name": "Sydney Polo Club",
  "location": "Sydney, NSW",
  "founded_date": "2015-06-20"
}
```

### Field

**Create Field Request:**
```json
{
  "name": "Field #1",
  "location": "Brisbane",
  "grade": "Medium Goal"
}
```

**Valid Grades:**
- "High Goal"
- "Medium Goal"
- "Low Goal"
- "Zero"
- "Sub-Zero"

### Duty

**Create Duty Request:**
```json
{
  "type": "Umpire",
  "date": "2025-12-15T10:00:00",
  "notes": "Championship match",
  "player_id": 5,
  "match_id": 12
}
```

**Valid Duty Types:**
- "Umpire"
- "Centre Table"
- "Goal Umpire"

## Troubleshooting

### Common Issues

1. **Foreign Key Constraint Errors**
   - Ensure the `players` and `matches` tables exist before running the migration
   - Check that referenced IDs exist when creating duties

2. **Port Already in Use**
   - Kill the process using the port: `kill -9 $(lsof -t -i:3000)`
   - Or change the port in your `.env` file

3. **Database Connection Issues**
   - Check your `.env` file for correct database credentials
   - Ensure MySQL is running: `systemctl status mysql`

4. **Import/Export Errors**
   - Make sure all files use ES6 module syntax (`import`/`export`)
   - Check that `package.json` has `"type": "module"`

## Rollback Instructions

If you need to rollback the changes:

```sql
-- Rollback SQL
DROP TABLE IF EXISTS duties;
DROP TABLE IF EXISTS fields;
DROP TABLE IF EXISTS clubs;

-- Remove foreign keys from existing tables (if they were added)
ALTER TABLE teams DROP FOREIGN KEY teams_ibfk_club;
ALTER TABLE teams DROP COLUMN club_id;

ALTER TABLE players DROP FOREIGN KEY players_ibfk_club;
ALTER TABLE players DROP COLUMN club_id;

ALTER TABLE tournaments DROP FOREIGN KEY tournaments_ibfk_field;
ALTER TABLE tournaments DROP COLUMN field_id;

ALTER TABLE matches DROP FOREIGN KEY matches_ibfk_field;
ALTER TABLE matches DROP COLUMN field_id;
```

Then remove the code files and revert `server.js` changes using git:

```bash
git checkout server.js
rm models/club.model.js models/field.model.js models/duty.model.js
rm controllers/club.controller.js controllers/field.controller.js controllers/duty.controller.js
rm validators/club.validator.js validators/field.validator.js validators/duty.validator.js
rm routes/club.routes.js routes/field.routes.js routes/duty.routes.js
```

## Next Steps

After successful deployment:

1. Update your iOS app to integrate with these new endpoints
2. Test the full flow from iOS app to backend
3. Monitor logs for any errors
4. Update your API documentation if you have external docs

## Support

If you encounter any issues during deployment, check:
- Server logs: `pm2 logs` or `journalctl -u your-service`
- Database logs: `/var/log/mysql/error.log`
- Application logs in your configured logging directory
