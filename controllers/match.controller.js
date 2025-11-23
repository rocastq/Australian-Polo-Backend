import * as Match from '../models/match.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listMatches = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const tournamentId = req.query.tournament_id || null;

  const { matches, total } = await Match.getAllMatches({ limit, offset, tournamentId });

  res.json({
    data: matches,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getMatch = asyncHandler(async (req, res) => {
  const match = await Match.getMatchById(req.params.id);
  if (!match) throw new AppError('Match not found', 404);
  res.json(match);
});

export const createMatch = asyncHandler(async (req, res) => {
  const { tournament_id, team1_id, team2_id, scheduled_time } = req.body;
  const match = await Match.createMatch({ tournament_id, team1_id, team2_id, scheduled_time });
  res.status(201).json(match);
});

export const updateMatch = asyncHandler(async (req, res) => {
  const existing = await Match.getMatchById(req.params.id);
  if (!existing) throw new AppError('Match not found', 404);

  const { team1_id, team2_id, scheduled_time, result } = req.body;
  const match = await Match.updateMatch(req.params.id, { team1_id, team2_id, scheduled_time, result });
  res.json(match);
});

export const deleteMatch = asyncHandler(async (req, res) => {
  const existing = await Match.getMatchById(req.params.id);
  if (!existing) throw new AppError('Match not found', 404);

  await Match.deleteMatch(req.params.id);
  res.json({ message: 'Match deleted successfully' });
});