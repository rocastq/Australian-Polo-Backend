import { Router } from 'express';
import {
  listTournaments,
  getTournament,
  createTournament,
  updateTournament,
  deleteTournament,
} from '../controllers/tournament.controller.js';
import { createTournamentValidator, updateTournamentValidator, idValidator } from '../validators/tournament.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/tournaments:
 *   get:
 *     tags:
 *       - Tournaments
 *     summary: List all tournaments with pagination
 *     parameters:
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *         description: Page number
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *         description: Number of items per page
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Search by name or location
 *     responses:
 *       200:
 *         description: List of tournaments
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Tournament'
 *                 pagination:
 *                   type: object
 *                   properties:
 *                     page:
 *                       type: integer
 *                     limit:
 *                       type: integer
 *                     total:
 *                       type: integer
 *                     totalPages:
 *                       type: integer
 */
router.get('/', listTournaments);

/**
 * @openapi
 * /api/tournaments/{id}:
 *   get:
 *     tags:
 *       - Tournaments
 *     summary: Get a tournament by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Tournament ID
 *     responses:
 *       200:
 *         description: Tournament details
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Tournament'
 *       404:
 *         description: Tournament not found
 */
router.get('/:id', idValidator, validate, getTournament);

/**
 * @openapi
 * /api/tournaments:
 *   post:
 *     tags:
 *       - Tournaments
 *     summary: Create a new tournament
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/TournamentInput'
 *     responses:
 *       201:
 *         description: Tournament created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Tournament'
 *       400:
 *         description: Invalid input
 */
router.post('/', createTournamentValidator, validate, createTournament);

/**
 * @openapi
 * /api/tournaments/{id}:
 *   put:
 *     tags:
 *       - Tournaments
 *     summary: Update a tournament
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Tournament ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/TournamentInput'
 *     responses:
 *       200:
 *         description: Tournament updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Tournament'
 *       404:
 *         description: Tournament not found
 *   delete:
 *     tags:
 *       - Tournaments
 *     summary: Delete a tournament
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Tournament ID
 *     responses:
 *       200:
 *         description: Tournament deleted
 *       404:
 *         description: Tournament not found
 */
router.put('/:id', updateTournamentValidator, validate, updateTournament);
router.delete('/:id', idValidator, validate, deleteTournament);

export default router;