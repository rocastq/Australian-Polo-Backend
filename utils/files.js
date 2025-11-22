import fs from 'fs';
import dotenv from 'dotenv';
dotenv.config();

export function ensureUploadsDir(){
  const dir = process.env.UPLOAD_DIR || './uploads';
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}