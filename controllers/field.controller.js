import * as Field from '../models/field.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listFields = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { fields, total } = await Field.getAllFields({ limit, offset, search });

  res.json({
    data: fields,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getField = asyncHandler(async (req, res) => {
  const field = await Field.getFieldById(req.params.id);
  if (!field) throw new AppError('Field not found', 404);
  res.json(field);
});

export const createField = asyncHandler(async (req, res) => {
  const { name, location, grade } = req.body;
  const field = await Field.createField({ name, location, grade });
  res.status(201).json(field);
});

export const updateField = asyncHandler(async (req, res) => {
  const existing = await Field.getFieldById(req.params.id);
  if (!existing) throw new AppError('Field not found', 404);

  const { name, location, grade } = req.body;
  const field = await Field.updateField(req.params.id, { name, location, grade });
  res.json(field);
});

export const deleteField = asyncHandler(async (req, res) => {
  const existing = await Field.getFieldById(req.params.id);
  if (!existing) throw new AppError('Field not found', 404);

  await Field.deleteField(req.params.id);
  res.json({ message: 'Field deleted successfully' });
});
