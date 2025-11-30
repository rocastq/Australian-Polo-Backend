import pool from '../config/db.js';

export const getAllFields = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM fields WHERE is_active = TRUE';
  let countQuery = 'SELECT COUNT(*) as total FROM fields WHERE is_active = TRUE';
  const params = [];

  if (search) {
    query += ' AND (name LIKE ? OR location LIKE ?)';
    countQuery += ' AND (name LIKE ? OR location LIKE ?)';
    params.push(`%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY name ASC LIMIT ? OFFSET ?';

  const [fields] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    fields,
    total: countResult[0].total,
  };
};

export const getFieldById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM fields WHERE id = ?', [id]);
  return rows[0];
};

export const createField = async ({ name, location, grade }) => {
  const [res] = await pool.query(
    'INSERT INTO fields (name, location, grade) VALUES (?, ?, ?)',
    [name, location || null, grade || 'Medium Goal']
  );
  return { id: res.insertId, name, location, grade };
};

export const updateField = async (id, { name, location, grade }) => {
  await pool.query(
    'UPDATE fields SET name = ?, location = ?, grade = ? WHERE id = ?',
    [name, location, grade, id]
  );
  return { id, name, location, grade };
};

export const deleteField = async (id) => {
  await pool.query('UPDATE fields SET is_active = FALSE WHERE id = ?', [id]);
  return true;
};
