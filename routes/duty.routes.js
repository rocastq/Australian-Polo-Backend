import { Router } from 'express';
import {
  listDuties,
  getDuty,
  getDutiesByPlayer,
  getDutiesByMatch,
  createDuty,
  updateDuty,
  deleteDuty
} from '../controllers/duty.controller.js';
import { createDutyValidator, updateDutyValidator, idValidator } from '../validators/duty.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/duties:
 *   get:
 *     tags:
 *       - Duties
 *     summary: List all duties with pagination
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: List of duties
 */
router.get('/', listDuties);

/**
 * @openapi
 * /api/duties/player/{playerId}:
 *   get:
 *     tags:
 *       - Duties
 *     summary: Get duties by player
 *     parameters:
 *       - in: path
 *         name: playerId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: List of duties for the player
 */
router.get('/player/:playerId', idValidator, validate, getDutiesByPlayer);

/**
 * @openapi
 * /api/duties/match/{matchId}:
 *   get:
 *     tags:
 *       - Duties
 *     summary: Get duties by match
 *     parameters:
 *       - in: path
 *         name: matchId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: List of duties for the match
 */
router.get('/match/:matchId', idValidator, validate, getDutiesByMatch);

/**
 * @openapi
 * /api/duties/{id}:
 *   get:
 *     tags:
 *       - Duties
 *     summary: Get a duty by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Duty details
 *       404:
 *         description: Duty not found
 */
router.get('/:id', idValidator, validate, getDuty);

/**
 * @openapi
 * /api/duties:
 *   post:
 *     tags:
 *       - Duties
 *     summary: Create a new duty
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - type
 *               - date
 *             properties:
 *               type:
 *                 type: string
 *                 enum: [Umpire, Centre Table, Goal Umpire]
 *               date:
 *                 type: string
 *                 format: date-time
 *               notes:
 *                 type: string
 *                 nullable: true
 *               player_id:
 *                 type: integer
 *                 nullable: true
 *               match_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Duty created
 */
router.post('/', createDutyValidator, validate, createDuty);

/**
 * @openapi
 * /api/duties/{id}:
 *   put:
 *     tags:
 *       - Duties
 *     summary: Update a duty
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *     responses:
 *       200:
 *         description: Duty updated
 *       404:
 *         description: Duty not found
 */
router.put('/:id', updateDutyValidator, validate, updateDuty);

/**
 * @openapi
 * /api/duties/{id}:
 *   delete:
 *     tags:
 *       - Duties
 *     summary: Delete a duty
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Duty deleted
 *       404:
 *         description: Duty not found
 */
router.delete('/:id', idValidator, validate, deleteDuty);

export default router;
