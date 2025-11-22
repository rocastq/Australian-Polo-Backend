import { Router } from 'express';
import { listTeams, getTeam, createTeam, updateTeam, deleteTeam } from '../controllers/team.controller.js';

const r = Router();
r.get('/', listTeams);
r.get('/:id', getTeam);
r.post('/', createTeam);
r.put('/:id', updateTeam);
r.delete('/:id', deleteTeam);

export default r;