import { Router } from 'express';
import {
  listRosters,
  getRoster,
  createRoster,
  updateRoster,
  deleteRoster,
} from '../controllers/rosters.controller.js';

const router = Router();

router.get('/', listRosters);
router.get('/:id', getRoster);
router.post('/', createRoster);
router.put('/:id', updateRoster);
router.delete('/:id', deleteRoster);

export default router;
