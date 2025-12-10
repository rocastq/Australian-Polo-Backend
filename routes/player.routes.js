import { Router } from 'express';
import { listPlayers, getPlayer, createPlayer, updatePlayer, deletePlayer } from '../controllers/player.controller.js';
import { createPlayerValidator, updatePlayerValidator, idValidator } from '../validators/player.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/players:
 *   get:
 *     tags:
 *       - Players
 *     summary: List all players with pagination
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
 *         description: Search by first_name, surname, or state
 *     responses:
 *       200:
 *         description: List of players
 */
router.get('/', listPlayers);

/**
 * @openapi
 * /api/players/{id}:
 *   get:
 *     tags:
 *       - Players
 *     summary: Get a player by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Player details
 *       404:
 *         description: Player not found
 */
router.get('/:id', idValidator, validate, getPlayer);

/**
 * @openapi
 * /api/players:
 *   post:
 *     tags:
 *       - Players
 *     summary: Create a new player
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - first_name
 *               - surname
 *             properties:
 *               first_name:
 *                 type: string
 *                 maxLength: 100
 *               surname:
 *                 type: string
 *                 maxLength: 100
 *               state:
 *                 type: string
 *                 enum: [NSW, VIC, QLD, SA, WA]
 *                 nullable: true
 *               handicap_jun_2025:
 *                 type: integer
 *                 nullable: true
 *               womens_handicap_jun_2025:
 *                 type: integer
 *                 nullable: true
 *               handicap_dec_2026:
 *                 type: integer
 *                 nullable: true
 *               womens_handicap_dec_2026:
 *                 type: integer
 *                 nullable: true
 *               team_id:
 *                 type: integer
 *                 nullable: true
 *               position:
 *                 type: string
 *                 maxLength: 50
 *                 nullable: true
 *               club_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Player created
 */
router.post('/', createPlayerValidator, validate, createPlayer);

/**
 * @openapi
 * /api/players/{id}:
 *   put:
 *     tags:
 *       - Players
 *     summary: Update a player
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
 *             required:
 *               - first_name
 *               - surname
 *             properties:
 *               first_name:
 *                 type: string
 *                 maxLength: 100
 *               surname:
 *                 type: string
 *                 maxLength: 100
 *               state:
 *                 type: string
 *                 enum: [NSW, VIC, QLD, SA, WA]
 *                 nullable: true
 *               handicap_jun_2025:
 *                 type: integer
 *                 nullable: true
 *               womens_handicap_jun_2025:
 *                 type: integer
 *                 nullable: true
 *               handicap_dec_2026:
 *                 type: integer
 *                 nullable: true
 *               womens_handicap_dec_2026:
 *                 type: integer
 *                 nullable: true
 *               team_id:
 *                 type: integer
 *                 nullable: true
 *               position:
 *                 type: string
 *                 maxLength: 50
 *                 nullable: true
 *               club_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       200:
 *         description: Player updated
 *       404:
 *         description: Player not found
 */
router.put('/:id', updatePlayerValidator, validate, updatePlayer);

/**
 * @openapi
 * /api/players/{id}:
 *   delete:
 *     tags:
 *       - Players
 *     summary: Delete a player
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Player deleted
 *       404:
 *         description: Player not found
 */
router.delete('/:id', idValidator, validate, deletePlayer);

export default router;
