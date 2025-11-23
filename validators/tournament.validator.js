import { body, param } from 'express-validator';

export const createTournamentValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 200 })
    .withMessage('Name must be between 2 and 200 characters'),
  body('location')
    .trim()
    .notEmpty()
    .withMessage('Location is required')
    .isLength({ max: 200 })
    .withMessage('Location must not exceed 200 characters'),
  body('start_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('Start date must be a valid date'),
  body('end_date')
    .optional({ nullable: true })
    .isISO8601()
    .withMessage('End date must be a valid date')
    .custom((value, { req }) => {
      if (value && req.body.start_date && new Date(value) < new Date(req.body.start_date)) {
        throw new Error('End date must be after start date');
      }
      return true;
    }),
];

export const updateTournamentValidator = [
  param('id').isInt().withMessage('Tournament ID must be an integer'),
  ...createTournamentValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
