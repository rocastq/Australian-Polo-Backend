import { Router } from 'express';
import { listAwards, getAward, createAward, updateAward, deleteAward } from '../controllers/award.controller.js';
import { createAwardValidator, updateAwardValidator, idValidator } from '../validators/award.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/awards:
 *   get:
 *     tags:
 *       - Awards
 *     summary: List all awards with pagination
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
 *         description: List of awards
 */
router.get('/', listAwards);

/**
 * @openapi
 * /api/awards/{id}:
 *   get:
 *     tags:
 *       - Awards
 *     summary: Get an award by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Award details
 *       404:
 *         description: Award not found
 */
router.get('/:id', idValidator, validate, getAward);

/**
 * @openapi
 * /api/awards:
 *   post:
 *     tags:
 *       - Awards
 *     summary: Create a new award
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - title
 *             properties:
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *                 nullable: true
 *               entity_type:
 *                 type: string
 *                 enum: [player, team, horse]
 *                 nullable: true
 *               entity_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Award created
 */
router.post('/', createAwardValidator, validate, createAward);

/**
 * @openapi
 * /api/awards/{id}:
 *   put:
 *     tags:
 *       - Awards
 *     summary: Update an award
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
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *                 nullable: true
 *               entity_type:
 *                 type: string
 *                 enum: [player, team, horse]
 *                 nullable: true
 *               entity_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       200:
 *         description: Award updated
 *       404:
 *         description: Award not found
 */
router.put('/:id', updateAwardValidator, validate, updateAward);

/**
 * @openapi
 * /api/awards/{id}:
 *   delete:
 *     tags:
 *       - Awards
 *     summary: Delete an award
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Award deleted
 *       404:
 *         description: Award not found
 */
router.delete('/:id', idValidator, validate, deleteAward);

export default router;