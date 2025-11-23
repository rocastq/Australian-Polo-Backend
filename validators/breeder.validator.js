import { body, param } from 'express-validator';

export const createBreederValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Name must be between 2 and 100 characters'),
  body('contact_info')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 255 })
    .withMessage('Contact info must not exceed 255 characters'),
];

export const updateBreederValidator = [
  param('id').isInt().withMessage('Breeder ID must be an integer'),
  ...createBreederValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
