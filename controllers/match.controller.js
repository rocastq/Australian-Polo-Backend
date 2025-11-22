import * as Match from '../models/match.model.js';

export const listMatches = async (req, res) => {
  const { tournamentId } = req.params;
  const matches = await Match.getMatchesByTournament(tournamentId);
  res.json(matches);
};

export const getMatch = async (req, res) => {
  const m = await Match.getMatchById(req.params.id);
  if (!m) return res.status(404).json({ message: 'Match not found' });
  res.json(m);
};

export const createMatch = async (req, res) => {
  const { tournament_id, team1_id, team2_id, scheduled_time } = req.body;
  const m = await Match.createMatch({ tournament_id, team1_id, team2_id, scheduled_time });
  res.status(201).json(m);
};

export const updateMatch = async (req, res) => {
  const { team1_id, team2_id, scheduled_time, result } = req.body;
  const m = await Match.updateMatch(req.params.id, { team1_id, team2_id, scheduled_time, result });
  res.json(m);
};

export const deleteMatch = async (req, res) => {
  await Match.deleteMatch(req.params.id);
  res.json({ message: 'Deleted' });
};