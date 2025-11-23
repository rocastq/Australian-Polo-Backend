import pool from '../config/db.js';

export const getAllPlayers = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM players';
  let countQuery = 'SELECT COUNT(*) as total FROM players';
  const params = [];

  if (search) {
    query += ' WHERE name LIKE ? OR position LIKE ?';
    countQuery += ' WHERE name LIKE ? OR position LIKE ?';
    params.push(`%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY id DESC LIMIT ? OFFSET ?';

  const [players] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    players,
    total: countResult[0].total,
  };
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