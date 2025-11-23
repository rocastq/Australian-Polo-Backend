import pool from '../config/db.js';

export const getAllBreeders = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM breeders';
  let countQuery = 'SELECT COUNT(*) as total FROM breeders';
  const params = [];

  if (search) {
    query += ' WHERE name LIKE ?';
    countQuery += ' WHERE name LIKE ?';
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

export const getBreederById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM breeders WHERE id = ?', [id]);
  return rows[0];
};

export const createBreeder = async ({ name, contact_info }) => {
  const [res] = await pool.query(
    'INSERT INTO breeders (name, contact_info) VALUES (?, ?)',
    [name, contact_info]
  );
  return { id: res.insertId, name, contact_info };
};

export const updateBreeder = async (id, { name, contact_info }) => {
  await pool.query('UPDATE breeders SET name = ?, contact_info = ? WHERE id = ?', [name, contact_info, id]);
  return { id, name, contact_info };
};

export const deleteBreeder = async (id) => {
  await pool.query('DELETE FROM breeders WHERE id = ?', [id]);
  return true;
};