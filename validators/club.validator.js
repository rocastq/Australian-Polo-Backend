import { body, param } from 'express-validator';

export const createClubValidator = [
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
  body('founded_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('Founded date must be a valid date'),
];

export const updateClubValidator = [
  param('id').isInt().withMessage('Club ID must be an integer'),
  ...createClubValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
