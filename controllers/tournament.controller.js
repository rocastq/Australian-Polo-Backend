import * as Tournament from '../models/tournament.model.js';

export const listTournaments = async (req, res) => {
  const tournaments = await Tournament.getAllTournaments();
  res.json(tournaments);
};

export const getTournament = async (req, res) => {
  const t = await Tournament.getTournamentById(req.params.id);
  if (!t) return res.status(404).json({ message: 'Tournament not found' });
  res.json(t);
};

export const createTournament = async (req, res) => {
  const { name, location, start_date, end_date } = req.body;
  const t = await Tournament.createTournament({ name, location, start_date, end_date });
  res.status(201).json(t);
};

export const updateTournament = async (req, res) => {
  const { name, location, start_date, end_date } = req.body;
  const t = await Tournament.updateTournament(req.params.id, { name, location, start_date, end_date });
  res.json(t);
};

export const deleteTournament = async (req, res) => {
  await Tournament.deleteTournament(req.params.id);
  res.json({ message: 'Deleted' });
};