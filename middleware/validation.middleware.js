import { validationResult } from 'express-validator';
import { AppError } from './error.middleware.js';

export const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map(err => `${err.path}: ${err.msg}`);
    throw new AppError(errorMessages.join(', '), 400);
  }
  next();
};
