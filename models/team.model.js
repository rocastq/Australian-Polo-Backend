import pool from '../config/db.js';

export const getAllTeams = async () => {
  const [rows] = await pool.query('SELECT * FROM teams ORDER BY id DESC');
  return rows;
};

export const getTeamById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM teams WHERE id = ?', [id]);
  return rows[0];
};

export const createTeam = async ({ name, coach }) => {
  const [res] = await pool.query('INSERT INTO teams (name, coach) VALUES (?, ?)', [name, coach]);
  return { id: res.insertId, name, coach };
};

export const updateTeam = async (id, { name, coach }) => {
  await pool.query('UPDATE teams SET name = ?, coach = ? WHERE id = ?', [name, coach, id]);
  return { id, name, coach };
};

export const deleteTeam = async (id) => {
  await pool.query('DELETE FROM teams WHERE id = ?', [id]);
  return true;
};