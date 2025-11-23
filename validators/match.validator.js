import { body, param } from 'express-validator';

export const createMatchValidator = [
  body('tournament_id')
    .notEmpty()
    .withMessage('Tournament ID is required')
    .isInt()
    .withMessage('Tournament ID must be an integer'),
  body('team1_id')
    .notEmpty()
    .withMessage('Team 1 ID is required')
    .isInt()
    .withMessage('Team 1 ID must be an integer'),
  body('team2_id')
    .notEmpty()
    .withMessage('Team 2 ID is required')
    .isInt()
    .withMessage('Team 2 ID must be an integer'),
  body('scheduled_time')
    .notEmpty()
    .withMessage('Scheduled time is required')
    .isISO8601()
    .withMessage('Scheduled time must be a valid ISO 8601 date'),
];

export const updateMatchValidator = [
  param('id').isInt().withMessage('Match ID must be an integer'),
  body('team1_id')
    .optional()
    .isInt()
    .withMessage('Team 1 ID must be an integer'),
  body('team2_id')
    .optional()
    .isInt()
    .withMessage('Team 2 ID must be an integer'),
  body('scheduled_time')
    .optional()
    .isISO8601()
    .withMessage('Scheduled time must be a valid ISO 8601 date'),
  body('result')
    .optional({ nullable: true })
    .isString()
    .withMessage('Result must be a string'),
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
