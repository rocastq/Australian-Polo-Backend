import pool from '../config/db.js';

export const getAllTournaments = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM tournaments';
  let countQuery = 'SELECT COUNT(*) as total FROM tournaments';
  const params = [];

  if (search) {
    query += ' WHERE name LIKE ? OR location LIKE ?';
    countQuery += ' WHERE name LIKE ? OR location LIKE ?';
    params.push(`%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY id DESC LIMIT ? OFFSET ?';

  const [tournaments] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    tournaments,
    total: countResult[0].total,
  };
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