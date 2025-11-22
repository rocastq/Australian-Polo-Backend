import pool from '../config/db.js';

export const getAllAwards = async () => {
  const [rows] = await pool.query('SELECT * FROM awards ORDER BY id DESC');
  return rows;
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