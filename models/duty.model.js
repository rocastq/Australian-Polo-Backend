import pool from '../config/db.js';

export const getAllDuties = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = `
    SELECT d.*,
           p.name as player_name,
           m.scheduled_time as match_time
    FROM duties d
    LEFT JOIN players p ON d.player_id = p.id
    LEFT JOIN matches m ON d.match_id = m.id
  `;
  let countQuery = 'SELECT COUNT(*) as total FROM duties d';
  const params = [];

  if (search) {
    query += ' WHERE (d.type LIKE ? OR d.notes LIKE ? OR p.name LIKE ?)';
    countQuery += ' LEFT JOIN players p ON d.player_id = p.id WHERE (d.type LIKE ? OR d.notes LIKE ? OR p.name LIKE ?)';
    params.push(`%${search}%`, `%${search}%`, `%${search}%`);
  }

  query += ' ORDER BY d.date DESC LIMIT ? OFFSET ?';

  const [duties] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  return {
    duties,
    total: countResult[0].total,
  };
};

export const getDutiesByPlayer = async (playerId) => {
  const [duties] = await pool.query(
    'SELECT * FROM duties WHERE player_id = ? ORDER BY date DESC',
    [playerId]
  );
  return duties;
};

export const getDutiesByMatch = async (matchId) => {
  const [duties] = await pool.query(
    'SELECT * FROM duties WHERE match_id = ? ORDER BY type',
    [matchId]
  );
  return duties;
};

export const getDutyById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM duties WHERE id = ?', [id]);
  return rows[0];
};

export const createDuty = async ({ type, date, notes, player_id, match_id }) => {
  const [res] = await pool.query(
    'INSERT INTO duties (type, date, notes, player_id, match_id) VALUES (?, ?, ?, ?, ?)',
    [type, date, notes || null, player_id || null, match_id || null]
  );
  return { id: res.insertId, type, date, notes, player_id, match_id };
};

export const updateDuty = async (id, { type, date, notes, player_id, match_id }) => {
  await pool.query(
    'UPDATE duties SET type = ?, date = ?, notes = ?, player_id = ?, match_id = ? WHERE id = ?',
    [type, date, notes, player_id, match_id, id]
  );
  return { id, type, date, notes, player_id, match_id };
};

export const deleteDuty = async (id) => {
  await pool.query('DELETE FROM duties WHERE id = ?', [id]);
  return true;
};
