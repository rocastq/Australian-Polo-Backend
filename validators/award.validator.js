import { body, param } from 'express-validator';

export const createAwardValidator = [
  body('title')
    .trim()
    .notEmpty()
    .withMessage('Title is required')
    .isLength({ min: 2, max: 200 })
    .withMessage('Title must be between 2 and 200 characters'),
  body('description')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 500 })
    .withMessage('Description must not exceed 500 characters'),
  body('entity_type')
    .optional({ nullable: true })
    .trim()
    .isIn(['player', 'team', 'horse'])
    .withMessage('Entity type must be one of: player, team, horse'),
  body('entity_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Entity ID must be an integer'),
];

export const updateAwardValidator = [
  param('id').isInt().withMessage('Award ID must be an integer'),
  ...createAwardValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
