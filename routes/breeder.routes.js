import { Router } from 'express';
import { listBreeders, getBreeder, createBreeder, updateBreeder, deleteBreeder } from '../controllers/breeder.controller.js';
import { createBreederValidator, updateBreederValidator, idValidator } from '../validators/breeder.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/breeders:
 *   get:
 *     tags:
 *       - Breeders
 *     summary: List all breeders with pagination
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
 *         description: List of breeders
 */
router.get('/', listBreeders);

/**
 * @openapi
 * /api/breeders/{id}:
 *   get:
 *     tags:
 *       - Breeders
 *     summary: Get a breeder by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Breeder details
 *       404:
 *         description: Breeder not found
 */
router.get('/:id', idValidator, validate, getBreeder);

/**
 * @openapi
 * /api/breeders:
 *   post:
 *     tags:
 *       - Breeders
 *     summary: Create a new breeder
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
 *               contact_info:
 *                 type: string
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Breeder created
 */
router.post('/', createBreederValidator, validate, createBreeder);

/**
 * @openapi
 * /api/breeders/{id}:
 *   put:
 *     tags:
 *       - Breeders
 *     summary: Update a breeder
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
 *               contact_info:
 *                 type: string
 *                 nullable: true
 *     responses:
 *       200:
 *         description: Breeder updated
 *       404:
 *         description: Breeder not found
 */
router.put('/:id', updateBreederValidator, validate, updateBreeder);

/**
 * @openapi
 * /api/breeders/{id}:
 *   delete:
 *     tags:
 *       - Breeders
 *     summary: Delete a breeder
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Breeder deleted
 *       404:
 *         description: Breeder not found
 */
router.delete('/:id', idValidator, validate, deleteBreeder);

export default router;