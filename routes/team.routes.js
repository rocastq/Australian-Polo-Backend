import { Router } from 'express';
import { listTeams, getTeam, createTeam, updateTeam, deleteTeam } from '../controllers/team.controller.js';
import { createTeamValidator, updateTeamValidator, idValidator } from '../validators/team.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/teams:
 *   get:
 *     tags:
 *       - Teams
 *     summary: List all teams with pagination
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
 *         description: List of teams
 */
router.get('/', listTeams);

/**
 * @openapi
 * /api/teams/{id}:
 *   get:
 *     tags:
 *       - Teams
 *     summary: Get a team by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Team details
 *       404:
 *         description: Team not found
 */
router.get('/:id', idValidator, validate, getTeam);

/**
 * @openapi
 * /api/teams:
 *   post:
 *     tags:
 *       - Teams
 *     summary: Create a new team
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
 *               coach:
 *                 type: string
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Team created
 */
router.post('/', createTeamValidator, validate, createTeam);

/**
 * @openapi
 * /api/teams/{id}:
 *   put:
 *     tags:
 *       - Teams
 *     summary: Update a team
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
 *         description: Team updated
 *       404:
 *         description: Team not found
 */
router.put('/:id', updateTeamValidator, validate, updateTeam);

/**
 * @openapi
 * /api/teams/{id}:
 *   delete:
 *     tags:
 *       - Teams
 *     summary: Delete a team
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Team deleted
 *       404:
 *         description: Team not found
 */
router.delete('/:id', idValidator, validate, deleteTeam);

export default router;