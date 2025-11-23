import * as Breeder from '../models/breeder.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listBreeders = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { items, total } = await Breeder.getAllBreeders({ limit, offset, search });

  res.json({
    data: items,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getBreeder = asyncHandler(async (req, res) => {
  const breeder = await Breeder.getBreederById(req.params.id);
  if (!breeder) throw new AppError('Breeder not found', 404);
  res.json(breeder);
});

export const createBreeder = asyncHandler(async (req, res) => {
  const { name, contact_info } = req.body;
  const breeder = await Breeder.createBreeder({ name, contact_info });
  res.status(201).json(breeder);
});

export const updateBreeder = asyncHandler(async (req, res) => {
  const existing = await Breeder.getBreederById(req.params.id);
  if (!existing) throw new AppError('Breeder not found', 404);

  const { name, contact_info } = req.body;
  const breeder = await Breeder.updateBreeder(req.params.id, { name, contact_info });
  res.json(breeder);
});

export const deleteBreeder = asyncHandler(async (req, res) => {
  const existing = await Breeder.getBreederById(req.params.id);
  if (!existing) throw new AppError('Breeder not found', 404);

  await Breeder.deleteBreeder(req.params.id);
  res.json({ message: 'Breeder deleted successfully' });
});