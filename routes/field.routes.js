import { Router } from 'express';
import { listFields, getField, createField, updateField, deleteField } from '../controllers/field.controller.js';
import { createFieldValidator, updateFieldValidator, idValidator } from '../validators/field.validator.js';
import { validate } from '../middleware/validation.middleware.js';

const router = Router();

/**
 * @openapi
 * /api/fields:
 *   get:
 *     tags:
 *       - Fields
 *     summary: List all fields with pagination
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
 *         description: List of fields
 */
router.get('/', listFields);

/**
 * @openapi
 * /api/fields/{id}:
 *   get:
 *     tags:
 *       - Fields
 *     summary: Get a field by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Field details
 *       404:
 *         description: Field not found
 */
router.get('/:id', idValidator, validate, getField);

/**
 * @openapi
 * /api/fields:
 *   post:
 *     tags:
 *       - Fields
 *     summary: Create a new field
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
 *               grade:
 *                 type: string
 *                 enum: [High Goal, Medium Goal, Low Goal, Zero, Sub-Zero]
 *                 nullable: true
 *     responses:
 *       201:
 *         description: Field created
 */
router.post('/', createFieldValidator, validate, createField);

/**
 * @openapi
 * /api/fields/{id}:
 *   put:
 *     tags:
 *       - Fields
 *     summary: Update a field
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
 *         description: Field updated
 *       404:
 *         description: Field not found
 */
router.put('/:id', updateFieldValidator, validate, updateField);

/**
 * @openapi
 * /api/fields/{id}:
 *   delete:
 *     tags:
 *       - Fields
 *     summary: Delete a field
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Field deleted
 *       404:
 *         description: Field not found
 */
router.delete('/:id', idValidator, validate, deleteField);

export default router;
