// /controllers/team.controller.js
import * as Team from '../models/team.model.js';

export const listTeams = async (req, res) => {
  const teams = await Team.getAllTeams();
  res.json(teams);
};

export const getTeam = async (req, res) => {
  const t = await Team.getTeamById(req.params.id);
  if (!t) return res.status(404).json({ message: 'Team not found' });
  res.json(t);
};

export const createTeam = async (req, res) => {
  const { name, coach } = req.body;
  const t = await Team.createTeam({ name, coach });
  res.status(201).json(t);
};

export const updateTeam = async (req, res) => {
  const { name, coach } = req.body;
  const t = await Team.updateTeam(req.params.id, { name, coach });
  res.json(t);
};

export const deleteTeam = async (req, res) => {
  await Team.deleteTeam(req.params.id);
  res.json({ message: 'Deleted' });
};