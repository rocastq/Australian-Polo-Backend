import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { createUser, findUserByEmail } from '../models/user.model.js';
import { asyncHandler } from '../middleware/error.middleware.js';
import { AppError } from '../middleware/error.middleware.js';
import { config } from '../config/env.js';

export const register = asyncHandler(async (req, res) => {
  const { name, email, password } = req.body;

  const existing = await findUserByEmail(email);
  if (existing) throw new AppError('Email already registered', 409);

  const passwordHash = await bcrypt.hash(password, 10);
  const user = await createUser({ name, email, passwordHash });
  const token = jwt.sign({ sub: user.id }, config.jwt.secret, { expiresIn: config.jwt.expiresIn });

  res.status(201).json({ user, token });
});

export const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  const user = await findUserByEmail(email);
  if (!user) throw new AppError('Invalid credentials', 401);

  const ok = await bcrypt.compare(password, user.password);
  if (!ok) throw new AppError('Invalid credentials', 401);

  const token = jwt.sign({ sub: user.id }, config.jwt.secret, { expiresIn: config.jwt.expiresIn });

  res.json({
    user: { id: user.id, name: user.name, email: user.email },
    token,
  });
});