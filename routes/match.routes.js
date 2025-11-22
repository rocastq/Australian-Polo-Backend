import { Router } from 'express';
import { listMatches, getMatch, createMatch, updateMatch, deleteMatch } from '../controllers/match.controller.js';

const r = Router();

// List matches for a tournament
r.get('/tournament/:tournamentId', listMatches);

r.get('/:id', getMatch);
r.post('/', createMatch);
r.put('/:id', updateMatch);
r.delete('/:id', deleteMatch);

export default r;