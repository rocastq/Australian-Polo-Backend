import pool from '../config/db.js';

export const getAllRosters = async () => {
  const [rows] = await pool.query('SELECT * FROM rosters ORDER BY id DESC');
  return rows;
};

export const getRosterById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM rosters WHERE id = ?', [id]);
  return rows[0];
};

export const createRoster = async (data) => {
  const [res] = await pool.query('INSERT INTO rosters SET ?', [data]);
  return { id: res.insertId, ...data };
};

export const updateRoster = async (id, data) => {
  await pool.query('UPDATE rosters SET ? WHERE id = ?', [data, id]);
  return { id, ...data };
};

export const deleteRoster = async (id) => {
  await pool.query('DELETE FROM rosters WHERE id = ?', [id]);
  return true;
};
