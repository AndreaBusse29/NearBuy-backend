import { pool } from './pool';
import fs from 'fs';
import path from 'path';

/**
 * Checks if database tables exist
 */
export async function checkTablesExist(): Promise<boolean> {
  try {
    const result = await pool.query(`
      SELECT EXISTS (
        SELECT FROM information_schema.tables
        WHERE table_schema = 'public'
        AND table_name = 'users'
      );
    `);
    return result.rows[0].exists;
  } catch (error) {
    console.error('Error checking if tables exist:', error);
    return false;
  }
}

/**
 * Gets count of records in a table
 */
export async function getTableCount(tableName: string): Promise<number> {
  try {
    const result = await pool.query(`SELECT COUNT(*) FROM ${tableName}`);
    return parseInt(result.rows[0].count, 10);
  } catch (error) {
    console.error(`Error getting count for table ${tableName}:`, error);
    return 0;
  }
}

/**
 * Initializes database with schema and seed data if needed
 * This is a fallback for non-Docker environments
 */
export async function initializeDatabase(): Promise<void> {
  try {
    const tablesExist = await checkTablesExist();

    if (!tablesExist) {
      console.log('Database tables not found. Initializing database...');

      // Run schema file
      const schemaPath = path.join(__dirname, '../../database/init/01-schema.sql');
      if (fs.existsSync(schemaPath)) {
        const schema = fs.readFileSync(schemaPath, 'utf8');
        await pool.query(schema);
        console.log('✓ Database schema created successfully');
      } else {
        console.warn('Schema file not found at:', schemaPath);
      }

      // Run seed file
      const seedPath = path.join(__dirname, '../../database/init/02-seed.sql');
      if (fs.existsSync(seedPath)) {
        const seed = fs.readFileSync(seedPath, 'utf8');
        await pool.query(seed);
        console.log('✓ Test data seeded successfully');
      } else {
        console.warn('Seed file not found at:', seedPath);
      }
    } else {
      console.log('Database tables already exist');

      // Display record counts
      const tables = ['users', 'categories', 'products', 'locations', 'favorites', 'messages'];
      for (const table of tables) {
        const count = await getTableCount(table);
        console.log(`  - ${table}: ${count} records`);
      }
    }
  } catch (error) {
    console.error('Database initialization failed:', error);
    throw error;
  }
}

/**
 * Displays database statistics
 */
export async function displayDatabaseStats(): Promise<void> {
  try {
    const tablesExist = await checkTablesExist();

    if (tablesExist) {
      console.log('\n📊 Database Statistics:');
      const tables = ['users', 'categories', 'products', 'locations', 'favorites', 'messages'];

      for (const table of tables) {
        const count = await getTableCount(table);
        console.log(`   ${table.padEnd(12)} : ${count} records`);
      }
      console.log('');
    }
  } catch (error) {
    console.error('Error displaying database stats:', error);
  }
}
