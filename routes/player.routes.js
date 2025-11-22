import { Router } from 'express';
import { listPlayers, getPlayer, createPlayer, updatePlayer, deletePlayer } from '../controllers/player.controller.js';

const r = Router();
r.get('/', listPlayers);
r.get('/:id', getPlayer);
r.post('/', createPlayer);
r.put('/:id', updatePlayer);
r.delete('/:id', deletePlayer);

export default r;