import { body, param } from 'express-validator';

export const createHorseValidator = [
  body('name')
    .trim()
    .notEmpty()
    .withMessage('Name is required')
    .isLength({ min: 2, max: 100 })
    .withMessage('Name must be between 2 and 100 characters'),
  body('pedigree')
    .optional({ nullable: true })
    .isObject()
    .withMessage('Pedigree must be an object'),
  body('breeder_id')
    .optional({ nullable: true })
    .isInt()
    .withMessage('Breeder ID must be an integer'),
  body('owner')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 100 })
    .withMessage('Owner name must not exceed 100 characters'),
  body('tamer')
    .optional({ nullable: true })
    .trim()
    .isLength({ max: 100 })
    .withMessage('Tamer name must not exceed 100 characters'),
];

export const updateHorseValidator = [
  param('id').isInt().withMessage('Horse ID must be an integer'),
  ...createHorseValidator,
];

export const idValidator = [
  param('id').isInt().withMessage('ID must be an integer'),
];
