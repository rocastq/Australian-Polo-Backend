import { body, param } from 'express-validator';

const validGrades = ['High Goal', 'Medium Goal', 'Low Goal', 'Zero', 'Sub-Zero'];

export const createFieldValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Name must be between 2 and 100 characters'),
  body('location')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 255 })
    .withMessage('Location must not exceed 255 characters'),
  body('grade')
    .optional({ nullable: true })
    .isIn(validGrades)
    .withMessage(`Grade must be one of: ${validGrades.join(', ')}`),
];

export const updateFieldValidator = [
  param('id').isInt().withMessage('Field ID must be an integer'),
  ...createFieldValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
