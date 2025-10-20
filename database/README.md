# Database Setup

This directory contains SQL scripts for database initialization and seeding.

## Directory Structure

```
database/
├── init/           - SQL scripts executed on database initialization
│   ├── 01-schema.sql   - Database schema (tables, indexes, triggers)
│   └── 02-seed.sql     - Test data for development
├── seeds/          - Additional seed files (not auto-loaded)
└── README.md       - This file
```

## How It Works

### Docker Environment
When using Docker Compose, the PostgreSQL container automatically executes all `.sql` files in the `init/` directory on first startup. Files are executed in alphabetical order.

The `docker-compose.yml` and `docker-compose.dev.yml` files mount this directory:
```yaml
volumes:
  - ./database/init:/docker-entrypoint-initdb.d
```

**Important:** These scripts only run once when the database volume is first created. To re-run:
```bash
npm run docker:clean  # Removes containers and volumes
npm run docker:dev    # Starts fresh with init scripts
```

### Local Development (Non-Docker)
The application includes a fallback mechanism in `src/database/init.ts` that:
1. Checks if tables exist on startup
2. If not, reads and executes the SQL files from `database/init/`
3. Creates schema and populates test data
4. Displays statistics of loaded data

## Database Schema

### Tables
- **users** - User accounts with authentication
- **categories** - Product categories
- **locations** - Geographic locations
- **products** - Product listings
- **favorites** - User-saved products
- **messages** - User-to-user messages

### Features
- UUID primary keys with `uuid-ossp` extension
- Automatic timestamps with triggers
- Foreign key relationships with CASCADE/SET NULL
- Indexes for common queries
- Array types for product images

## Test Data

The seed file (`02-seed.sql`) includes:
- 4 test users (all with password: 'password123')
- 6 product categories
- 4 locations in San Francisco
- 10 sample products
- Multiple favorites and messages

All UUIDs are hardcoded for consistent references in tests and development.

## Modifying the Schema

1. Edit `01-schema.sql` for schema changes
2. Edit `02-seed.sql` for test data changes
3. To apply changes in Docker: `npm run docker:clean && npm run docker:dev`
4. To apply changes locally: Delete tables or restart with empty database

## Adding Custom Seed Data

Place additional seed files in the `seeds/` directory. These won't auto-load but can be:
- Manually executed via `psql`
- Loaded through custom scripts
- Used for specific testing scenarios
