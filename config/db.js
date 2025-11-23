import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,

  // **Important for date handling**
  dateStrings: ['DATE', 'DATETIME'],
  timezone: 'Z',   // interpret as UTC

  waitForConnections: true,
  connectionLimit: 10,
  acquireTimeout: 60000,
  timeout: 60000,
  reconnect: true,
  ssl: process.env.DB_SSL === 'true' ? {
    rejectUnauthorized: false
  } : false
});

pool.on('connection', (conn) => {
  // Force session timezone to UTC
  conn.query("SET time_zone = '+00:00';");
});

export default pool;