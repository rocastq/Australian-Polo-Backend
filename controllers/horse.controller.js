import * as Horse from '../models/horse.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listHorses = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { horses, total } = await Horse.getAllHorses({ limit, offset, search });

  res.json({
    data: horses,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getHorse = asyncHandler(async (req, res) => {
  const horse = await Horse.getHorseById(req.params.id);
  if (!horse) throw new AppError('Horse not found', 404);
  res.json(horse);
});

export const createHorse = asyncHandler(async (req, res) => {
  const { name, pedigree, breeder_id } = req.body;
  const horse = await Horse.createHorse({ name, pedigree, breeder_id });
  res.status(201).json(horse);
});

export const updateHorse = asyncHandler(async (req, res) => {
  const existing = await Horse.getHorseById(req.params.id);
  if (!existing) throw new AppError('Horse not found', 404);

  const { name, pedigree, breeder_id } = req.body;
  const horse = await Horse.updateHorse(req.params.id, { name, pedigree, breeder_id });
  res.json(horse);
});

export const deleteHorse = asyncHandler(async (req, res) => {
  const existing = await Horse.getHorseById(req.params.id);
  if (!existing) throw new AppError('Horse not found', 404);

  await Horse.deleteHorse(req.params.id);
  res.json({ message: 'Horse deleted successfully' });
});