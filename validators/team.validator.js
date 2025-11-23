import { body, param } from 'express-validator';

export const createTeamValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Name must be between 2 and 100 characters'),
  body('coach')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 100 })
    .withMessage('Coach name must not exceed 100 characters'),
];

export const updateTeamValidator = [
  param('id').isInt().withMessage('Team ID must be an integer'),
  ...createTeamValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
