import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';

import tournamentRoutes from './routes/tournament.routes.js';
import matchRoutes from './routes/match.routes.js';
import teamRoutes from './routes/team.routes.js';
import playerRoutes from './routes/player.routes.js';
import horseRoutes from './routes/horse.routes.js';
import breederRoutes from './routes/breeder.routes.js';
import awardRoutes from './routes/award.routes.js';

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Mount routes
app.use('/api/tournaments', tournamentRoutes);
app.use('/api/matches', matchRoutes);
app.use('/api/teams', teamRoutes);
app.use('/api/players', playerRoutes);
app.use('/api/horses', horseRoutes);
app.use('/api/breeders', breederRoutes);
app.use('/api/awards', awardRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});