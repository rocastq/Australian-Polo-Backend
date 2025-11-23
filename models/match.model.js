import pool from '../config/db.js';

export const getAllMatches = async ({ limit = 10, offset = 0, tournamentId = null }) => {
  let query = 'SELECT * FROM matches';
  let countQuery = 'SELECT COUNT(*) as total FROM matches';
  const params = [];

  if (tournamentId) {
    query += ' WHERE tournament_id = ?';
    countQuery += ' WHERE tournament_id = ?';
    params.push(tournamentId);
  }

  query += ' ORDER BY scheduled_time DESC LIMIT ? OFFSET ?';

  const [matches] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    matches,
    total: countResult[0].total,
  };
};

export const getMatchById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM matches WHERE id = ?', [id]);
  return rows[0];
};

export const createMatch = async ({ tournament_id, team1_id, team2_id, scheduled_time }) => {
  const [res] = await pool.query(
    'INSERT INTO matches (tournament_id, team1_id, team2_id, scheduled_time) VALUES (?, ?, ?, ?)',
    [tournament_id, team1_id, team2_id, scheduled_time]
  );
  return { id: res.insertId, tournament_id, team1_id, team2_id, scheduled_time };
};

export const updateMatch = async (id, { team1_id, team2_id, scheduled_time, result }) => {
  await pool.query(
    'UPDATE matches SET team1_id = ?, team2_id = ?, scheduled_time = ?, result = ? WHERE id = ?',
    [team1_id, team2_id, scheduled_time, result, id]
  );
  return { id, team1_id, team2_id, scheduled_time, result };
};

export const deleteMatch = async (id) => {
  await pool.query('DELETE FROM matches WHERE id = ?', [id]);
  return true;
};