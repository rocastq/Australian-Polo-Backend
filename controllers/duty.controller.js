import * as Duty from '../models/duty.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listDuties = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { duties, total } = await Duty.getAllDuties({ limit, offset, search });

  res.json({
    data: duties,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getDutiesByPlayer = asyncHandler(async (req, res) => {
  const duties = await Duty.getDutiesByPlayer(req.params.playerId);
  res.json(duties);
});

export const getDutiesByMatch = asyncHandler(async (req, res) => {
  const duties = await Duty.getDutiesByMatch(req.params.matchId);
  res.json(duties);
});

export const getDuty = asyncHandler(async (req, res) => {
  const duty = await Duty.getDutyById(req.params.id);
  if (!duty) throw new AppError('Duty not found', 404);
  res.json(duty);
});

export const createDuty = asyncHandler(async (req, res) => {
  const { type, date, notes, player_id, match_id } = req.body;
  const duty = await Duty.createDuty({ type, date, notes, player_id, match_id });
  res.status(201).json(duty);
});

export const updateDuty = asyncHandler(async (req, res) => {
  const existing = await Duty.getDutyById(req.params.id);
  if (!existing) throw new AppError('Duty not found', 404);

  const { type, date, notes, player_id, match_id } = req.body;
  const duty = await Duty.updateDuty(req.params.id, { type, date, notes, player_id, match_id });
  res.json(duty);
});

export const deleteDuty = asyncHandler(async (req, res) => {
  const existing = await Duty.getDutyById(req.params.id);
  if (!existing) throw new AppError('Duty not found', 404);

  await Duty.deleteDuty(req.params.id);
  res.json({ message: 'Duty deleted successfully' });
});
