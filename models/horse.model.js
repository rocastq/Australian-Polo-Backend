import pool from '../config/db.js';

export const getAllHorses = async () => {
  const [rows] = await pool.query('SELECT * FROM horses ORDER BY id DESC');
  return rows;
};

export const getHorseById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM horses WHERE id = ?', [id]);
  return rows[0];
};

export const createHorse = async ({ name, pedigree, breeder_id }) => {
  const [res] = await pool.query(
    'INSERT INTO horses (name, pedigree, breeder_id) VALUES (?, ?, ?)',
    [name, JSON.stringify(pedigree), breeder_id]
  );
  return { id: res.insertId, name, pedigree, breeder_id };
};

export const updateHorse = async (id, { name, pedigree, breeder_id }) => {
  await pool.query(
    'UPDATE horses SET name = ?, pedigree = ?, breeder_id = ? WHERE id = ?',
    [name, JSON.stringify(pedigree), breeder_id, id]
  );
  return { id, name, pedigree, breeder_id };
};

export const deleteHorse = async (id) => {
  await pool.query('DELETE FROM horses WHERE id = ?', [id]);
  return true;
};