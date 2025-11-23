import * as Award from '../models/award.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listAwards = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { items, total } = await Award.getAllAwards({ limit, offset, search });

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

export const getAward = asyncHandler(async (req, res) => {
  const award = await Award.getAwardById(req.params.id);
  if (!award) throw new AppError('Award not found', 404);
  res.json(award);
});

export const createAward = asyncHandler(async (req, res) => {
  const { title, description, entity_type, entity_id } = req.body;
  const award = await Award.createAward({ title, description, entity_type, entity_id });
  res.status(201).json(award);
});

export const updateAward = asyncHandler(async (req, res) => {
  const existing = await Award.getAwardById(req.params.id);
  if (!existing) throw new AppError('Award not found', 404);

  const { title, description, entity_type, entity_id } = req.body;
  const award = await Award.updateAward(req.params.id, { title, description, entity_type, entity_id });
  res.json(award);
});

export const deleteAward = asyncHandler(async (req, res) => {
  const existing = await Award.getAwardById(req.params.id);
  if (!existing) throw new AppError('Award not found', 404);

  await Award.deleteAward(req.params.id);
  res.json({ message: 'Award deleted successfully' });
});