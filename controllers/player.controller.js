// /controllers/player.controller.js
import * as Player from '../models/player.model.js';

export const listPlayers = async (req, res) => {
  const players = await Player.getAllPlayers();
  res.json(players);
};

export const getPlayer = async (req, res) => {
  const p = await Player.getPlayerById(req.params.id);
  if (!p) return res.status(404).json({ message: 'Player not found' });
  res.json(p);
};

export const createPlayer = async (req, res) => {
  const { name, team_id, position } = req.body;
  const p = await Player.createPlayer({ name, team_id, position });
  res.status(201).json(p);
};

export const updatePlayer = async (req, res) => {
  const { name, team_id, position } = req.body;
  const p = await Player.updatePlayer(req.params.id, { name, team_id, position });
  res.json(p);
};

export const deletePlayer = async (req, res) => {
  await Player.deletePlayer(req.params.id);
  res.json({ message: 'Deleted' });
};