import { Router } from 'express';
import { listClubs, getClub, createClub, updateClub, deleteClub } from '../controllers/club.controller.js';
import { createClubValidator, updateClubValidator, idValidator } from '../validators/club.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/clubs:
 *   get:
 *     tags:
 *       - Clubs
 *     summary: List all clubs with pagination
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
 *         description: List of clubs
 */
router.get('/', listClubs);

/**
 * @openapi
 * /api/clubs/{id}:
 *   get:
 *     tags:
 *       - Clubs
 *     summary: Get a club by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Club details
 *       404:
 *         description: Club not found
 */
router.get('/:id', idValidator, validate, getClub);

/**
 * @openapi
 * /api/clubs:
 *   post:
 *     tags:
 *       - Clubs
 *     summary: Create a new club
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *             properties:
 *               name:
 *                 type: string
 *               location:
 *                 type: string
 *                 nullable: true
 *               founded_date:
 *                 type: string
 *                 format: date
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Club created
 */
router.post('/', createClubValidator, validate, createClub);

/**
 * @openapi
 * /api/clubs/{id}:
 *   put:
 *     tags:
 *       - Clubs
 *     summary: Update a club
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
 *         description: Club updated
 *       404:
 *         description: Club not found
 */
router.put('/:id', updateClubValidator, validate, updateClub);

/**
 * @openapi
 * /api/clubs/{id}:
 *   delete:
 *     tags:
 *       - Clubs
 *     summary: Delete a club
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Club deleted
 *       404:
 *         description: Club not found
 */
router.delete('/:id', idValidator, validate, deleteClub);

export default router;
