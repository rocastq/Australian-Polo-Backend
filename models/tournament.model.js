import pool from '../config/db.js';

export const getAllTournaments = async () => {
  const [rows] = await pool.query('SELECT * FROM tournaments ORDER BY id DESC');
  return rows;
};

export const getTournamentById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM tournaments WHERE id = ?', [id]);
  return rows[0];
};

export const createTournament = async ({ name, location, start_date, end_date }) => {
  const [res] = await pool.query(
    'INSERT INTO tournaments (name, location, start_date, end_date) VALUES (?, ?, ?, ?)',
    [name, location, start_date, end_date]
  );
  return { id: res.insertId, name, location, start_date, end_date };
};

export const updateTournament = async (id, { name, location, start_date, end_date }) => {
  await pool.query(
    'UPDATE tournaments SET name = ?, location = ?, start_date = ?, end_date = ? WHERE id = ?',
    [name, location, start_date, end_date, id]
  );
  return { id, name, location, start_date, end_date };
};

export const deleteTournament = async (id) => {
  await pool.query('DELETE FROM tournaments WHERE id = ?', [id]);
  return true;
};