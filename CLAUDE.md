# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NearBuy-backend is a Node.js/TypeScript backend service with PostgreSQL database integration.

## Development Commands

### Running Locally (without Docker)
- `npm run dev` - Start development server with hot-reload (uses nodemon + ts-node)
- `npm run build` - Compile TypeScript to JavaScript in `dist/` directory
- `npm start` - Run production build from `dist/`

### Running with Docker
- `npm run docker:dev` - Start development environment with hot-reload (app + database)
- `npm run docker:dev:down` - Stop development containers
- `npm run docker:prod` - Start production environment (app + database)
- `npm run docker:prod:down` - Stop production containers
- `npm run docker:clean` - Stop containers and remove volumes

### Environment Setup

**Local Development (without Docker):**
1. Copy `.env.example` to `.env`
2. Update database credentials and configuration in `.env`
3. Ensure PostgreSQL is running and database exists

**Docker Development:**
- No `.env` file needed for Docker - environment variables are defined in `docker-compose.yml`
- Database is automatically created and configured
- Run `npm run docker:dev` to start both app and database

## Project Architecture

### Directory Structure
```
src/
├── config/         - Application configuration and environment variables
├── database/       - Database connection pool and query utilities
├── models/         - Data models and schemas
├── controllers/    - Request handlers and business logic
├── routes/         - API route definitions
├── services/       - Business logic and external service integrations
├── middleware/     - Express middleware (auth, validation, etc.)
└── utils/          - Utility functions and helpers
```

### Key Modules

**Database Connection (src/database/pool.ts)**
- Exports a PostgreSQL connection pool configured from environment variables
- Provides `query()` function for direct queries with logging
- Provides `getClient()` for transaction management with automatic timeout warnings
- Handles connection errors and graceful shutdown

**Configuration (src/config/index.ts)**
- Centralizes all environment variable access
- Exports typed configuration object for server and database settings

**Entry Point (src/index.ts)**
- Tests database connection on startup
- Automatically initializes database schema and seeds data if needed
- Displays database statistics (record counts) on startup
- Handles graceful shutdown on SIGTERM/SIGINT signals
- Ready for web framework integration (Express, Fastify, etc.)

**Database Initialization (src/database/init.ts)**
- Checks if tables exist and creates them if needed
- Runs SQL scripts from `database/init/` directory
- Displays table record counts for verification
- Fallback mechanism for local (non-Docker) development

## TypeScript Configuration

- Target: ES2020
- Module: CommonJS
- Strict mode enabled with comprehensive type checking
- Source maps and declarations generated for debugging
- Output directory: `dist/`

## Database

### PostgreSQL Setup
- PostgreSQL client: `pg` (node-postgres)
- Connection pooling enabled with configurable max connections
- Query logging includes execution time and row count
- Client checkout timeout warnings after 5 seconds

### Database Schema
The database includes the following tables:
- **users**: User accounts with authentication
- **categories**: Product categories
- **locations**: Geographic locations for products
- **products**: Product listings with seller, category, and location
- **favorites**: User-saved products
- **messages**: User-to-user messaging about products

All tables use UUID primary keys and include timestamps. The schema file is located at `database/init/01-schema.sql`.

### Automatic Initialization
**Docker Environment:**
- SQL scripts in `database/init/` are automatically executed on first container startup
- Files are executed in alphabetical order:
  1. `01-schema.sql` - Creates tables, indexes, and triggers
  2. `02-seed.sql` - Populates test data (4 users, 6 categories, 10 products, etc.)
- Scripts only run once when the PostgreSQL container is first created
- To reinitialize: run `npm run docker:clean` to remove volumes, then start again

**Local Development (non-Docker):**
- Application automatically runs initialization scripts on startup if tables don't exist
- Uses `src/database/init.ts` to check for existing tables and apply schema/seeds
- Safe to run multiple times (uses `IF NOT EXISTS` and `ON CONFLICT` clauses)

### Test Data
The seed file includes realistic test data:
- 4 test users (password: 'password123' for all)
- 6 product categories (Electronics, Furniture, Clothing, Books, Sports, Home & Garden)
- 10 sample products with various sellers and locations
- Multiple favorites and messages between users
- All data uses consistent UUIDs for easy reference in development

## Docker Configuration

### Multi-stage Dockerfile
- **Builder stage**: Compiles TypeScript to JavaScript
- **Production stage**: Runs optimized Node.js image with production dependencies only
- Uses non-root user for security
- Based on Alpine Linux for minimal image size

### Docker Compose Files
- `docker-compose.yml` - Production setup with optimized build
- `docker-compose.dev.yml` - Development setup with hot-reload and volume mounting
- `Dockerfile.dev` - Development-specific image with all dependencies

### Container Services
- **app**: Node.js application (port 3000)
- **db**: PostgreSQL 15 database (port 5432)
  - Health checks ensure database is ready before app starts
  - Persistent volume for data storage
  - Default credentials: postgres/postgres (change for production)