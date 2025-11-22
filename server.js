import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import teamsRoutes from './routes/teams.routes.js';
import playersRoutes from './routes/players.routes.js';
import rostersRoutes from './routes/rosters.routes.js';
import tournamentsRoutes from './routes/tournaments.routes.js';
import matchesRoutes from './routes/matches.routes.js';
import awardsRoutes from './routes/awards.routes.js';
import horsesRoutes from './routes/horses.routes.js';
import breedersRoutes from './routes/breeders.routes.js';
import { ensureUploadsDir } from './utils/files.js';

dotenv.config();
ensureUploadsDir();

const app = express();
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(process.env.UPLOAD_DIR || './uploads'));

app.use('/api/auth', authRoutes);
app.use('/api/teams', teamsRoutes);
app.use('/api/players', playersRoutes);
app.use('/api/rosters', rostersRoutes);
app.use('/api/tournaments', tournamentsRoutes);
app.use('/api/matches', matchesRoutes);
app.use('/api/awards', awardsRoutes);
app.use('/api/horses', horsesRoutes);
app.use('/api/breeders', breedersRoutes);

app.get('/', (req, res) => res.json({ ok: true }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Polo backend listening on ${PORT}`));