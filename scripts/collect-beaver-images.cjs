#!/usr/bin/env node
/**
 * Collect existing CareerWiki beaver thumbnails for LoRA review/training.
 *
 * Sources:
 * - jobs.image_url
 * - majors.image_url
 *
 * Usage:
 *   node scripts/collect-beaver-images.cjs
 *   node scripts/collect-beaver-images.cjs --count=60 --priority-slugs=소방관,치과의사
 *   node scripts/collect-beaver-images.cjs --jobs-only
 *   node scripts/collect-beaver-images.cjs --majors-only
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const PROD_URL = 'https://careerwiki.org';
const DEFAULT_COUNT = 40;
const DEFAULT_OUTPUT = path.join(__dirname, 'lora-training-data');
const TRIGGER_WORD = 'cwbeaver';
const MIN_SIZE = 50 * 1024;

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (!arg.startsWith('--')) continue;
    const [key, ...rest] = arg.slice(2).split('=');
    args[key] = rest.length ? rest.join('=') : true;
  }
  return args;
}

function runD1Query(sql) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --command "${sql}" --json`,
    { cwd: path.join(__dirname, '..'), stdio: 'pipe', encoding: 'utf8' }
  );
  const parsed = JSON.parse(result);
  return parsed[0]?.results || parsed.results || [];
}

async function getRecordsWithImages({ includeJobs, includeMajors }) {
  const records = [];

  if (includeJobs) {
    records.push(
      ...runD1Query(
        "SELECT 'job' as source_type, slug, name, image_url, image_prompt FROM jobs WHERE image_url IS NOT NULL AND image_url != '' ORDER BY RANDOM() LIMIT 160"
      )
    );
  }

  if (includeMajors) {
    records.push(
      ...runD1Query(
        "SELECT 'major' as source_type, slug, name, image_url, image_prompt FROM majors WHERE image_url IS NOT NULL AND image_url != '' ORDER BY RANDOM() LIMIT 120"
      )
    );
  }

  return records;
}

async function downloadImage(imageUrl, outputPath) {
  try {
    const url = imageUrl.startsWith('http') ? imageUrl : `${PROD_URL}${imageUrl}`;
    const cleanUrl = url.split('?')[0];
    const res = await fetch(cleanUrl);
    if (!res.ok) return null;

    const buffer = Buffer.from(await res.arrayBuffer());
    if (buffer.length < MIN_SIZE) return null;

    fs.writeFileSync(outputPath, buffer);
    return buffer.length;
  } catch {
    return null;
  }
}

function generateCaption(imagePrompt) {
  const baseCaption = `${TRIGGER_WORD}, a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style`;
  if (imagePrompt && imagePrompt.length > 20) {
    return `${baseCaption}, ${imagePrompt.slice(0, 500)}`;
  }
  return baseCaption;
}

async function main() {
  const args = parseArgs();
  const count = Number.parseInt(args.count || `${DEFAULT_COUNT}`, 10) || DEFAULT_COUNT;
  const outputDir = args.output ? path.resolve(args.output) : DEFAULT_OUTPUT;
  const includeJobs = args['majors-only'] ? false : true;
  const includeMajors = args['jobs-only'] ? false : true;
  const prioritySlugs = String(args['priority-slugs'] || '')
    .split(',')
    .map(v => v.trim())
    .filter(Boolean);

  fs.mkdirSync(outputDir, { recursive: true });

  console.log(`\nCollecting CareerWiki beaver images`);
  console.log(`- count: ${count}`);
  console.log(`- output: ${outputDir}`);
  console.log(`- include jobs: ${includeJobs}`);
  console.log(`- include majors: ${includeMajors}`);

  const records = await getRecordsWithImages({ includeJobs, includeMajors });
  if (!records.length) {
    console.error('No records with image_url were found.');
    process.exit(1);
  }

  const prioritized = [];
  const others = [];
  for (const record of records) {
    if (prioritySlugs.includes(record.slug)) prioritized.push(record);
    else others.push(record);
  }
  const candidates = [...prioritized, ...others];

  let downloaded = 0;
  let skipped = 0;
  const metadata = [];

  for (const record of candidates) {
    if (downloaded >= count) break;
    if (!record.image_url) {
      skipped++;
      continue;
    }

    const prefix = record.source_type === 'major' ? 'major' : 'job';
    const safeSlug = (record.slug || record.name || `${prefix}_${downloaded}`).replace(/[/\\:*?"<>|]/g, '_');
    const ext = record.image_url.includes('.png') ? 'png' : 'webp';
    const imageName = `${prefix}__${safeSlug}.${ext}`;
    const captionName = `${prefix}__${safeSlug}.txt`;
    const imagePath = path.join(outputDir, imageName);
    const captionPath = path.join(outputDir, captionName);

    if (fs.existsSync(imagePath)) {
      downloaded++;
      metadata.push({
        sourceType: prefix,
        slug: record.slug || '',
        name: record.name || '',
        imageUrl: record.image_url || '',
        imagePrompt: record.image_prompt || '',
        localImageFile: imageName,
        localCaptionFile: captionName,
      });
      continue;
    }

    const size = await downloadImage(record.image_url, imagePath);
    if (!size) {
      skipped++;
      continue;
    }

    fs.writeFileSync(captionPath, generateCaption(record.image_prompt), 'utf8');
    metadata.push({
      sourceType: prefix,
      slug: record.slug || '',
      name: record.name || '',
      imageUrl: record.image_url || '',
      imagePrompt: record.image_prompt || '',
      localImageFile: imageName,
      localCaptionFile: captionName,
    });
    downloaded++;
  }

  fs.writeFileSync(path.join(outputDir, 'metadata.json'), JSON.stringify(metadata, null, 2), 'utf8');

  console.log(`\nDone`);
  console.log(`- downloaded: ${downloaded}`);
  console.log(`- skipped: ${skipped}`);
  console.log(`- metadata: ${path.join(outputDir, 'metadata.json')}`);
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
