const http = require('http');
const fs = require('fs');
const path = require('path');

// Load the built worker
const workerPath = path.join(__dirname, 'dist', '_worker.js');

// Check if file exists
if (!fs.existsSync(workerPath)) {
  console.error('❌ dist/_worker.js not found. Run `npm run build` first.');
  process.exit(1);
}

console.log('✅ Loading worker from:', workerPath);

// This won't work directly because _worker.js uses Cloudflare Workers APIs
// Let's just use wrangler in a simpler way instead

console.log('❌ Cannot run worker directly. Using wrangler is required.');
process.exit(1);
