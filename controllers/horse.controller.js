// /controllers/horse.controller.js
import * as Horse from '../models/horse.model.js';

export const listHorses = async (req, res) => {
  const horses = await Horse.getAllHorses();
  res.json(horses);
};

export const getHorse = async (req, res) => {
  const h = await Horse.getHorseById(req.params.id);
  if (!h) return res.status(404).json({ message: 'Horse not found' });
  // parse pedigree JSON
  try {
    h.pedigree = JSON.parse(h.pedigree);
  } catch (e) {
    // ignore
  }
  res.json(h);
};

export const createHorse = async (req, res) => {
  const { name, pedigree, breeder_id } = req.body;
  // pedigree is expected to be an object or array
  const h = await Horse.createHorse({ name, pedigree, breeder_id });
  res.status(201).json(h);
};

export const updateHorse = async (req, res) => {
  const { name, pedigree, breeder_id } = req.body;
  const h = await Horse.updateHorse(req.params.id, { name, pedigree, breeder_id });
  res.json(h);
};

export const deleteHorse = async (req, res) => {
  await Horse.deleteHorse(req.params.id);
  res.json({ message: 'Deleted' });
};