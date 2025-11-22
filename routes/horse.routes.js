import { Router } from 'express';
import { listHorses, getHorse, createHorse, updateHorse, deleteHorse } from '../controllers/horse.controller.js';

const r = Router();
r.get('/', listHorses);
r.get('/:id', getHorse);
r.post('/', createHorse);
r.put('/:id', updateHorse);
r.delete('/:id', deleteHorse);

export default r;