import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'N1caragua00.',
  database: process.env.DB_NAME || 'aupolo',
  waitForConnections: true,
  connectionLimit: 10,
});

export default pool;