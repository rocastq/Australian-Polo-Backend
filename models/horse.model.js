import pool from '../config/db.js';

export const getAllHorses = async ({ limit = 10, offset = 0, search = '' }) => {
  let query = 'SELECT * FROM horses';
  let countQuery = 'SELECT COUNT(*) as total FROM horses';
  const params = [];

  if (search) {
    query += ' WHERE name LIKE ?';
    countQuery += ' WHERE name LIKE ?';
    params.push(`%${search}%`);
  }

  query += ' ORDER BY id DESC LIMIT ? OFFSET ?';

  const [horses] = await pool.query(query, [...params, limit, offset]);
  const [countResult] = await pool.query(countQuery, params);

  // Parse pedigree JSON for each horse
  const parsedHorses = horses.map(h => {
    try {
      h.pedigree = JSON.parse(h.pedigree);
    } catch (e) {
      // Keep as is if not valid JSON
    }
    return h;
  });

  return {
    horses: parsedHorses,
    total: countResult[0].total,
  };
};

export const getHorseById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM horses WHERE id = ?', [id]);
  if (rows[0]) {
    try {
      rows[0].pedigree = JSON.parse(rows[0].pedigree);
    } catch (e) {
      // Keep as is if not valid JSON
    }
  }
  return rows[0];
};

export const createHorse = async ({ name, pedigree, breeder_id, owner, tamer }) => {
  const [res] = await pool.query(
    'INSERT INTO horses (name, pedigree, breeder_id, owner, tamer) VALUES (?, ?, ?, ?, ?)',
    [name, JSON.stringify(pedigree), breeder_id, owner, tamer]
  );
  return { id: res.insertId, name, pedigree, breeder_id, owner, tamer };
};

export const updateHorse = async (id, { name, pedigree, breeder_id, owner, tamer }) => {
  await pool.query(
    'UPDATE horses SET name = ?, pedigree = ?, breeder_id = ?, owner = ?, tamer = ? WHERE id = ?',
    [name, JSON.stringify(pedigree), breeder_id, owner, tamer, id]
  );
  return { id, name, pedigree, breeder_id, owner, tamer };
};

export const deleteHorse = async (id) => {
  await pool.query('DELETE FROM horses WHERE id = ?', [id]);
  return true;
};