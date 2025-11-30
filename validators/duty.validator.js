import { body, param } from 'express-validator';

const validDutyTypes = ['Umpire', 'Centre Table', 'Goal Umpire'];

export const createDutyValidator = [
  body('type')
    .trim()
    .notEmpty()
    .withMessage('Type is required')
    .isIn(validDutyTypes)
    .withMessage(`Type must be one of: ${validDutyTypes.join(', ')}`),
  body('date')
    .notEmpty()
    .withMessage('Date is required')
    .isISO8601()
    .withMessage('Date must be a valid datetime'),
  body('notes')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 1000 })
    .withMessage('Notes must not exceed 1000 characters'),
  body('player_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Player ID must be an integer'),
  body('match_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Match ID must be an integer'),
];

export const updateDutyValidator = [
  param('id').isInt().withMessage('Duty ID must be an integer'),
  ...createDutyValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
