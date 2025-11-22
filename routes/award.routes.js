import { Router } from 'express';
import { listAwards, getAward, createAward, updateAward, deleteAward } from '../controllers/award.controller.js';

const r = Router();
r.get('/', listAwards);
r.get('/:id', getAward);
r.post('/', createAward);
r.put('/:id', updateAward);
r.delete('/:id', deleteAward);

export default r;