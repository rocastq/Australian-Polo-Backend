import { body, param } from 'express-validator';

export const createPlayerValidator = [
  body('first_name')
    .trim()
    .notEmpty()
    .withMessage('First name is required')
    .isLength({ min: 1, max: 100 })
    .withMessage('First name must be between 1 and 100 characters'),
  body('surname')
    .trim()
    .notEmpty()
    .withMessage('Surname is required')
    .isLength({ min: 1, max: 100 })
    .withMessage('Surname must be between 1 and 100 characters'),
  body('state')
    .optional({ nullable: true })
    .isIn(['NSW', 'VIC', 'QLD', 'SA', 'WA'])
    .withMessage('State must be one of: NSW, VIC, QLD, SA, WA'),
  body('handicap_jun_2025')
    .optional({ nullable: true })
    .isInt({ min: -2, max: 10 })
    .withMessage('Handicap must be an integer between -2 and 10'),
  body('womens_handicap_jun_2025')
    .optional({ nullable: true })
    .isInt({ min: -1, max: 10 })
    .withMessage('Womens handicap must be an integer between -1 and 10'),
  body('handicap_dec_2026')
    .optional({ nullable: true })
    .isInt({ min: -2, max: 10 })
    .withMessage('Handicap must be an integer between -2 and 10'),
  body('womens_handicap_dec_2026')
    .optional({ nullable: true })
    .isInt({ min: -1, max: 10 })
    .withMessage('Womens handicap must be an integer between -1 and 10'),
  body('team_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Team ID must be an integer'),
  body('position')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 50 })
    .withMessage('Position must not exceed 50 characters'),
  body('club_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Club ID must be an integer'),
];

export const updatePlayerValidator = [
  param('id').isInt().withMessage('Player ID must be an integer'),
  ...createPlayerValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
