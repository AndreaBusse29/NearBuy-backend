import { config } from './config';
import { pool } from './database/pool';
import { initializeDatabase, displayDatabaseStats } from './database/init';

async function main() {
  try {
    console.log('🚀 Starting NearBuy Backend...');
    console.log(`Environment: ${config.server.nodeEnv}`);
    console.log('');

    // Test database connection
    const client = await pool.connect();
    console.log('✓ Database connected successfully');
    client.release();

    // Initialize database (creates tables and seeds data if needed)
    await initializeDatabase();

    // Display database statistics
    await displayDatabaseStats();

    // Start server here (e.g., Express, Fastify, etc.)
    console.log(`✓ Server is ready to start on port ${config.server.port}`);
    console.log('');
  } catch (error) {
    console.error('❌ Failed to start application:', error);
    process.exit(1);
  }
}

// Handle graceful shutdown
process.on('SIGTERM', async () => {
  console.log('SIGTERM signal received: closing HTTP server');
  await pool.end();
  process.exit(0);
});

process.on('SIGINT', async () => {
  console.log('SIGINT signal received: closing HTTP server');
  await pool.end();
  process.exit(0);
});

main();
