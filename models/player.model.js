import pool from '../config/db.js';

export const getAllPlayers = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM players';
  let countQuery = 'SELECT COUNT(*) as total FROM players';
  const params = [];

  if (search) {
    query += ' WHERE first_name LIKE ? OR surname LIKE ? OR state LIKE ?';
    countQuery += ' WHERE first_name LIKE ? OR surname LIKE ? OR state LIKE ?';
    params.push(`%${search}%`, `%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY surname ASC, first_name ASC LIMIT ? OFFSET ?';

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

export const createPlayer = async ({
  first_name,
  surname,
  state,
  handicap_jun_2025,
  womens_handicap_jun_2025,
  handicap_dec_2026,
  womens_handicap_dec_2026,
  team_id,
  position,
  club_id
}) => {
  const [res] = await pool.query(
    `INSERT INTO players (
      first_name, surname, state,
      handicap_jun_2025, womens_handicap_jun_2025,
      handicap_dec_2026, womens_handicap_dec_2026,
      team_id, position, club_id
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      first_name, surname, state,
      handicap_jun_2025, womens_handicap_jun_2025,
      handicap_dec_2026, womens_handicap_dec_2026,
      team_id, position, club_id
    ]
  );
  return {
    id: res.insertId,
    first_name,
    surname,
    state,
    handicap_jun_2025,
    womens_handicap_jun_2025,
    handicap_dec_2026,
    womens_handicap_dec_2026,
    team_id,
    position,
    club_id
  };
};

export const updatePlayer = async (id, {
  first_name,
  surname,
  state,
  handicap_jun_2025,
  womens_handicap_jun_2025,
  handicap_dec_2026,
  womens_handicap_dec_2026,
  team_id,
  position,
  club_id
}) => {
  await pool.query(
    `UPDATE players SET
      first_name = ?, surname = ?, state = ?,
      handicap_jun_2025 = ?, womens_handicap_jun_2025 = ?,
      handicap_dec_2026 = ?, womens_handicap_dec_2026 = ?,
      team_id = ?, position = ?, club_id = ?
    WHERE id = ?`,
    [
      first_name, surname, state,
      handicap_jun_2025, womens_handicap_jun_2025,
      handicap_dec_2026, womens_handicap_dec_2026,
      team_id, position, club_id,
      id
    ]
  );
  return {
    id,
    first_name,
    surname,
    state,
    handicap_jun_2025,
    womens_handicap_jun_2025,
    handicap_dec_2026,
    womens_handicap_dec_2026,
    team_id,
    position,
    club_id
  };
};

export const deletePlayer = async (id) => {
  await pool.query('DELETE FROM players WHERE id = ?', [id]);
  return true;
};
