// /controllers/breeder.controller.js
import * as Breeder from '../models/breeder.model.js';

export const listBreeders = async (req, res) => {
  const b = await Breeder.getAllBreeders();
  res.json(b);
};

export const getBreeder = async (req, res) => {
  const b = await Breeder.getBreederById(req.params.id);
  if (!b) return res.status(404).json({ message: 'Breeder not found' });
  res.json(b);
};

export const createBreeder = async (req, res) => {
  const { name, contact_info } = req.body;
  const b = await Breeder.createBreeder({ name, contact_info });
  res.status(201).json(b);
};

export const updateBreeder = async (req, res) => {
  const { name, contact_info } = req.body;
  const b = await Breeder.updateBreeder(req.params.id, { name, contact_info });
  res.json(b);
};

export const deleteBreeder = async (req, res) => {
  await Breeder.deleteBreeder(req.params.id);
  res.json({ message: 'Deleted' });
};