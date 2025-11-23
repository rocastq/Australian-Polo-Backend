import { Router } from 'express';
import { healthCheck, databaseHealth } from '../controllers/health.controller.js';

const router = Router();

router.get('/', healthCheck);
router.get('/db', databaseHealth);

export default router;
