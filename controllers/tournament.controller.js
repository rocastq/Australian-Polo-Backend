import * as Tournament from '../models/tournament.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listTournaments = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { tournaments, total } = await Tournament.getAllTournaments({ limit, offset, search });

  res.json({
    data: tournaments.map(t => ({
      id: t.id,
      name: t.name,
      location: t.location,
      start_date: t.start_date ?? null,
      end_date: t.end_date ?? null,
    })),
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getTournament = asyncHandler(async (req, res) => {
  const t = await Tournament.getTournamentById(req.params.id);
  if (!t) throw new AppError('Tournament not found', 404);

  res.json({
    id: t.id,
    name: t.name,
    location: t.location,
    start_date: t.start_date ?? null,
    end_date: t.end_date ?? null,
  });
});

export const createTournament = asyncHandler(async (req, res) => {
  const { name, location, start_date, end_date } = req.body;
  const t = await Tournament.createTournament({ name, location, start_date, end_date });

  res.status(201).json({
    id: t.id,
    name: t.name,
    location: t.location,
    start_date: t.start_date ?? null,
    end_date: t.end_date ?? null,
  });
});

export const updateTournament = asyncHandler(async (req, res) => {
  const existing = await Tournament.getTournamentById(req.params.id);
  if (!existing) throw new AppError('Tournament not found', 404);

  const { name, location, start_date, end_date } = req.body;
  const t = await Tournament.updateTournament(req.params.id, { name, location, start_date, end_date });

  res.json({
    id: t.id,
    name: t.name,
    location: t.location,
    start_date: t.start_date ?? null,
    end_date: t.end_date ?? null,
  });
});

export const deleteTournament = asyncHandler(async (req, res) => {
  const existing = await Tournament.getTournamentById(req.params.id);
  if (!existing) throw new AppError('Tournament not found', 404);

  await Tournament.deleteTournament(req.params.id);
  res.json({ message: 'Tournament deleted successfully' });
});