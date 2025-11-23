import * as Roster from '../models/roster.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listRosters = asyncHandler(async (req, res) => {
  const rosters = await Roster.getAllRosters();
  res.json({ data: rosters });
});

export const getRoster = asyncHandler(async (req, res) => {
  const roster = await Roster.getRosterById(req.params.id);
  if (!roster) throw new AppError('Roster not found', 404);
  res.json(roster);
});

export const createRoster = asyncHandler(async (req, res) => {
  const roster = await Roster.createRoster(req.body);
  res.status(201).json(roster);
});

export const updateRoster = asyncHandler(async (req, res) => {
  const existing = await Roster.getRosterById(req.params.id);
  if (!existing) throw new AppError('Roster not found', 404);

  const roster = await Roster.updateRoster(req.params.id, req.body);
  res.json(roster);
});

export const deleteRoster = asyncHandler(async (req, res) => {
  const existing = await Roster.getRosterById(req.params.id);
  if (!existing) throw new AppError('Roster not found', 404);

  await Roster.deleteRoster(req.params.id);
  res.json({ message: 'Roster deleted successfully' });
});
