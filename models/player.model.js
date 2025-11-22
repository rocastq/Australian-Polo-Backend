import pool from '../config/db.js';

export const getAllPlayers = async () => {
  const [rows] = await pool.query('SELECT * FROM players ORDER BY id DESC');
  return rows;
};

export const getPlayerById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM players WHERE id = ?', [id]);
  return rows[0];
};

export const createPlayer = async ({ name, team_id, position }) => {
  const [res] = await pool.query(
    'INSERT INTO players (name, team_id, position) VALUES (?, ?, ?)',
    [name, team_id, position]
  );
  return { id: res.insertId, name, team_id, position };
};

export const updatePlayer = async (id, { name, team_id, position }) => {
  await pool.query(
    'UPDATE players SET name = ?, team_id = ?, position = ? WHERE id = ?',
    [name, team_id, position, id]
  );
  return { id, name, team_id, position };
};

export const deletePlayer = async (id) => {
  await pool.query('DELETE FROM players WHERE id = ?', [id]);
  return true;
};