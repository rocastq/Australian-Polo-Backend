// /controllers/award.controller.js
import * as Award from '../models/award.model.js';

export const listAwards = async (req, res) => {
  const awards = await Award.getAllAwards();
  res.json(awards);
};

export const getAward = async (req, res) => {
  const a = await Award.getAwardById(req.params.id);
  if (!a) return res.status(404).json({ message: 'Award not found' });
  res.json(a);
};

export const createAward = async (req, res) => {
  const { title, description, entity_type, entity_id } = req.body;
  const a = await Award.createAward({ title, description, entity_type, entity_id });
  res.status(201).json(a);
};

export const updateAward = async (req, res) => {
  const { title, description, entity_type, entity_id } = req.body;
  const a = await Award.updateAward(req.params.id, { title, description, entity_type, entity_id });
  res.json(a);
};

export const deleteAward = async (req, res) => {
  await Award.deleteAward(req.params.id);
  res.json({ message: 'Deleted' });
};