import { Router } from 'express';
import { listMatches, getMatch, createMatch, updateMatch, deleteMatch } from '../controllers/match.controller.js';
import { createMatchValidator, updateMatchValidator, idValidator } from '../validators/match.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/matches:
 *   get:
 *     tags:
 *       - Matches
 *     summary: List all matches with pagination
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
 *         name: tournament_id
 *         schema:
 *           type: integer
 *         description: Filter matches by tournament ID
 *     responses:
 *       200:
 *         description: List of matches
 */
router.get('/', listMatches);

/**
 * @openapi
 * /api/matches/{id}:
 *   get:
 *     tags:
 *       - Matches
 *     summary: Get a match by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Match details
 *       404:
 *         description: Match not found
 */
router.get('/:id', idValidator, validate, getMatch);

/**
 * @openapi
 * /api/matches:
 *   post:
 *     tags:
 *       - Matches
 *     summary: Create a new match
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - tournament_id
 *               - team1_id
 *               - team2_id
 *               - scheduled_time
 *             properties:
 *               tournament_id:
 *                 type: integer
 *               team1_id:
 *                 type: integer
 *               team2_id:
 *                 type: integer
 *               scheduled_time:
 *                 type: string
 *                 format: date-time
 *     responses:
 *       201:
 *         description: Match created
 */
router.post('/', createMatchValidator, validate, createMatch);

/**
 * @openapi
 * /api/matches/{id}:
 *   put:
 *     tags:
 *       - Matches
 *     summary: Update a match
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
 *             properties:
 *               team1_id:
 *                 type: integer
 *               team2_id:
 *                 type: integer
 *               scheduled_time:
 *                 type: string
 *                 format: date-time
 *               result:
 *                 type: string
 *                 nullable: true
 *     responses:
 *       200:
 *         description: Match updated
 *       404:
 *         description: Match not found
 */
router.put('/:id', updateMatchValidator, validate, updateMatch);

/**
 * @openapi
 * /api/matches/{id}:
 *   delete:
 *     tags:
 *       - Matches
 *     summary: Delete a match
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Match deleted
 *       404:
 *         description: Match not found
 */
router.delete('/:id', idValidator, validate, deleteMatch);

export default router;