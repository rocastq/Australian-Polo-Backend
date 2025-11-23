import pool from '../config/db.js';
import { asyncHandler } from '../middleware/error.middleware.js';

export const healthCheck = asyncHandler(async (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
  });
});

export const databaseHealth = asyncHandler(async (req, res) => {
  const connection = await pool.getConnection();
  await connection.ping();
  connection.release();

  const [result] = await pool.query('SELECT COUNT(*) as count FROM information_schema.tables WHERE table_schema = ?', [
    process.env.DB_NAME,
  ]);

  res.json({
    status: 'ok',
    database: 'connected',
    tables: result[0].count,
    timestamp: new Date().toISOString(),
  });
});
