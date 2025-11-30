import pool from '../config/db.js';

export const getAllClubs = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM clubs WHERE is_active = TRUE';
  let countQuery = 'SELECT COUNT(*) as total FROM clubs WHERE is_active = TRUE';
  const params = [];

  if (search) {
    query += ' AND (name LIKE ? OR location LIKE ?)';
    countQuery += ' AND (name LIKE ? OR location LIKE ?)';
    params.push(`%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY name ASC LIMIT ? OFFSET ?';

  const [clubs] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    clubs,
    total: countResult[0].total,
  };
};

export const getClubById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM clubs WHERE id = ?', [id]);
  return rows[0];
};

export const createClub = async ({ name, location, founded_date }) => {
  const [res] = await pool.query(
    'INSERT INTO clubs (name, location, founded_date) VALUES (?, ?, ?)',
    [name, location || null, founded_date || null]
  );
  return { id: res.insertId, name, location, founded_date };
};

export const updateClub = async (id, { name, location, founded_date }) => {
  await pool.query(
    'UPDATE clubs SET name = ?, location = ?, founded_date = ? WHERE id = ?',
    [name, location, founded_date, id]
  );
  return { id, name, location, founded_date };
};

export const deleteClub = async (id) => {
  await pool.query('UPDATE clubs SET is_active = FALSE WHERE id = ?', [id]);
  return true;
};
