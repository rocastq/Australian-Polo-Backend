import { Router } from 'express';
import { listTournaments, getTournament, createTournament, updateTournament, deleteTournament } from '../controllers/tournament.controller.js';

const r = Router();
r.get('/', listTournaments);
r.get('/:id', getTournament);
r.post('/', createTournament);
r.put('/:id', updateTournament);
r.delete('/:id', deleteTournament);

export default r;