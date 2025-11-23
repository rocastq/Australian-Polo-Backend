import pool from '../config/db.js';

export const getAllAwards = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM awards';
  let countQuery = 'SELECT COUNT(*) as total FROM awards';
  const params = [];

  if (search) {
    query += ' WHERE title LIKE ?';
    countQuery += ' WHERE title LIKE ?';
    params.push(`%${search}%`);
  }

  query += ' ORDER BY id DESC LIMIT ? OFFSET ?';

  const [items] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    items,
    total: countResult[0].total,
  };
};

export const getAwardById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM awards WHERE id = ?', [id]);
  return rows[0];
};

export const createAward = async ({ title, description, entity_type, entity_id }) => {
  const [res] = await pool.query(
    'INSERT INTO awards (title, description, entity_type, entity_id) VALUES (?, ?, ?, ?)',
    [title, description, entity_type, entity_id]
  );
  return { id: res.insertId, title, description, entity_type, entity_id };
};

export const updateAward = async (id, { title, description, entity_type, entity_id }) => {
  await pool.query(
    'UPDATE awards SET title = ?, description = ?, entity_type = ?, entity_id = ? WHERE id = ?',
    [title, description, entity_type, entity_id, id]
  );
  return { id, title, description, entity_type, entity_id };
};

export const deleteAward = async (id) => {
  await pool.query('DELETE FROM awards WHERE id = ?', [id]);
  return true;
};