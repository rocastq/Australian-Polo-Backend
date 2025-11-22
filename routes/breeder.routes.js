import { Router } from 'express';
import { listBreeders, getBreeder, createBreeder, updateBreeder, deleteBreeder } from '../controllers/breeder.controller.js';

const r = Router();
r.get('/', listBreeders);
r.get('/:id', getBreeder);
r.post('/', createBreeder);
r.put('/:id', updateBreeder);
r.delete('/:id', deleteBreeder);

export default r;