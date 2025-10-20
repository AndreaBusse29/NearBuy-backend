# NearBuy Backend

A Node.js/TypeScript backend service with PostgreSQL integration.

## Getting Started

### Prerequisites

**Option 1: Docker (Recommended)**
- Docker
- Docker Compose

**Option 2: Local Development**
- Node.js (v18 or higher)
- PostgreSQL (v14 or higher)
- npm or yarn

### Installation

1. Clone the repository
```bash
git clone https://github.com/AndreaBusse29/NearBuy-backend.git
cd NearBuy-backend
```

2. Choose your setup method below

## Running with Docker (Recommended)

### Development Mode
Start the application with hot-reload and PostgreSQL:
```bash
npm run docker:dev
```

The application will be available at `http://localhost:3000`

Stop the containers:
```bash
npm run docker:dev:down
```

### Production Mode
Build and run the production-optimized containers:
```bash
npm run docker:prod
```

Stop production containers:
```bash
npm run docker:prod:down
```

### Clean Up
Remove all containers and volumes:
```bash
npm run docker:clean
```

## Running Locally (without Docker)

### Installation
1. Install dependencies
```bash
npm install
```

2. Set up environment variables
```bash
cp .env.example .env
# Edit .env with your database credentials
```

3. Create the database
```bash
createdb nearbuy
```

### Running the Application

Development mode (with hot-reload):
```bash
npm run dev
```

Build for production:
```bash
npm run build
```

Run production build:
```bash
npm start
```

## Project Structure

```
src/
├── config/         - Configuration and environment variables
├── database/       - Database connection and utilities
├── models/         - Data models
├── controllers/    - Request handlers
├── routes/         - API routes
├── services/       - Business logic
├── middleware/     - Middleware functions
└── utils/          - Utility functions
```

## Environment Variables

### Docker
Environment variables are configured in `docker-compose.yml` and `docker-compose.dev.yml`. No `.env` file is needed.

### Local Development
See `.env.example` for required environment variables. Copy it to `.env` and update with your credentials.

## Docker Configuration

This project includes:
- **Dockerfile**: Multi-stage production build with security best practices
- **Dockerfile.dev**: Development image with hot-reload support
- **docker-compose.yml**: Production environment setup
- **docker-compose.dev.yml**: Development environment with volume mounting

### Container Details
- **App Container**: Runs on port 3000
- **Database Container**: PostgreSQL 15 on port 5432
- **Volumes**: Persistent data storage for PostgreSQL

## License

ISC
