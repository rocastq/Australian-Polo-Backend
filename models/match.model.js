import pool from '../config/db.js';

export const getMatchesByTournament = async (tournamentId) => {
  const [rows] = await pool.query(
    'SELECT * FROM matches WHERE tournament_id = ? ORDER BY scheduled_time',
    [tournamentId]
  );
  return rows;
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