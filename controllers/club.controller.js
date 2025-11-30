import * as Club from '../models/club.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listClubs = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { clubs, total } = await Club.getAllClubs({ limit, offset, search });

  res.json({
    data: clubs,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getClub = asyncHandler(async (req, res) => {
  const club = await Club.getClubById(req.params.id);
  if (!club) throw new AppError('Club not found', 404);
  res.json(club);
});

export const createClub = asyncHandler(async (req, res) => {
  const { name, location, founded_date } = req.body;
  const club = await Club.createClub({ name, location, founded_date });
  res.status(201).json(club);
});

export const updateClub = asyncHandler(async (req, res) => {
  const existing = await Club.getClubById(req.params.id);
  if (!existing) throw new AppError('Club not found', 404);

  const { name, location, founded_date } = req.body;
  const club = await Club.updateClub(req.params.id, { name, location, founded_date });
  res.json(club);
});

export const deleteClub = asyncHandler(async (req, res) => {
  const existing = await Club.getClubById(req.params.id);
  if (!existing) throw new AppError('Club not found', 404);

  await Club.deleteClub(req.params.id);
  res.json({ message: 'Club deleted successfully' });
});
