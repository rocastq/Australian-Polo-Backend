import { body, param } from 'express-validator';

export const createPlayerValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Name must be between 2 and 100 characters'),
  body('team_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Team ID must be an integer'),
  body('position')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 50 })
    .withMessage('Position must not exceed 50 characters'),
];

export const updatePlayerValidator = [
  param('id').isInt().withMessage('Player ID must be an integer'),
  ...createPlayerValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
