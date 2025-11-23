import { Router } from 'express';
import { listHorses, getHorse, createHorse, updateHorse, deleteHorse } from '../controllers/horse.controller.js';
import { createHorseValidator, updateHorseValidator, idValidator } from '../validators/horse.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/horses:
 *   get:
 *     tags:
 *       - Horses
 *     summary: List all horses with pagination
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
 *         description: List of horses
 */
router.get('/', listHorses);

/**
 * @openapi
 * /api/horses/{id}:
 *   get:
 *     tags:
 *       - Horses
 *     summary: Get a horse by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Horse details
 *       404:
 *         description: Horse not found
 */
router.get('/:id', idValidator, validate, getHorse);

/**
 * @openapi
 * /api/horses:
 *   post:
 *     tags:
 *       - Horses
 *     summary: Create a new horse
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
 *               pedigree:
 *                 type: object
 *                 nullable: true
 *               breeder_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Horse created
 */
router.post('/', createHorseValidator, validate, createHorse);

/**
 * @openapi
 * /api/horses/{id}:
 *   put:
 *     tags:
 *       - Horses
 *     summary: Update a horse
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
 *               name:
 *                 type: string
 *               pedigree:
 *                 type: object
 *                 nullable: true
 *               breeder_id:
 *                 type: integer
 *                 nullable: true
 *     responses:
 *       200:
 *         description: Horse updated
 *       404:
 *         description: Horse not found
 */
router.put('/:id', updateHorseValidator, validate, updateHorse);

/**
 * @openapi
 * /api/horses/{id}:
 *   delete:
 *     tags:
 *       - Horses
 *     summary: Delete a horse
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Horse deleted
 *       404:
 *         description: Horse not found
 */
router.delete('/:id', idValidator, validate, deleteHorse);

export default router;