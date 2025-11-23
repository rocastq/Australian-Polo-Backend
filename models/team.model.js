import pool from '../config/db.js';

export const getAllTeams = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM teams';
  let countQuery = 'SELECT COUNT(*) as total FROM teams';
  const params = [];

  if (search) {
    query += ' WHERE name LIKE ? OR coach LIKE ?';
    countQuery += ' WHERE name LIKE ? OR coach LIKE ?';
    params.push(`%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY id DESC LIMIT ? OFFSET ?';

  const [teams] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    teams,
    total: countResult[0].total,
  };
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