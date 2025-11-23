import * as Player from '../models/player.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listPlayers = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { players, total } = await Player.getAllPlayers({ limit, offset, search });

  res.json({
    data: players,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getPlayer = asyncHandler(async (req, res) => {
  const player = await Player.getPlayerById(req.params.id);
  if (!player) throw new AppError('Player not found', 404);
  res.json(player);
});

export const createPlayer = asyncHandler(async (req, res) => {
  const { name, team_id, position } = req.body;
  const player = await Player.createPlayer({ name, team_id, position });
  res.status(201).json(player);
});

export const updatePlayer = asyncHandler(async (req, res) => {
  const existing = await Player.getPlayerById(req.params.id);
  if (!existing) throw new AppError('Player not found', 404);

  const { name, team_id, position } = req.body;
  const player = await Player.updatePlayer(req.params.id, { name, team_id, position });
  res.json(player);
});

export const deletePlayer = asyncHandler(async (req, res) => {
  const existing = await Player.getPlayerById(req.params.id);
  if (!existing) throw new AppError('Player not found', 404);

  await Player.deletePlayer(req.params.id);
  res.json({ message: 'Player deleted successfully' });
});