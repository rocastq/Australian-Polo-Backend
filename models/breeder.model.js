import pool from '../config/db.js';

export const getAllBreeders = async () => {
  const [rows] = await pool.query('SELECT * FROM breeders ORDER BY id DESC');
  return rows;
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