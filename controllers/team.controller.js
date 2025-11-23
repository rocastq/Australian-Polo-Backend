import * as Team from '../models/team.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';

export const listTeams = asyncHandler(async (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const offset = (page - 1) * limit;
  const search = req.query.search || '';

  const { teams, total } = await Team.getAllTeams({ limit, offset, search });

  res.json({
    data: teams,
    pagination: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  });
});

export const getTeam = asyncHandler(async (req, res) => {
  const team = await Team.getTeamById(req.params.id);
  if (!team) throw new AppError('Team not found', 404);
  res.json(team);
});

export const createTeam = asyncHandler(async (req, res) => {
  const { name, coach } = req.body;
  const team = await Team.createTeam({ name, coach });
  res.status(201).json(team);
});

export const updateTeam = asyncHandler(async (req, res) => {
  const existing = await Team.getTeamById(req.params.id);
  if (!existing) throw new AppError('Team not found', 404);

  const { name, coach } = req.body;
  const team = await Team.updateTeam(req.params.id, { name, coach });
  res.json(team);
});

export const deleteTeam = asyncHandler(async (req, res) => {
  const existing = await Team.getTeamById(req.params.id);
  if (!existing) throw new AppError('Team not found', 404);

  await Team.deleteTeam(req.params.id);
  res.json({ message: 'Team deleted successfully' });
});