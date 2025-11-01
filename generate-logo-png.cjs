const sharp = require('sharp');
const fs = require('fs');

// Large logo SVG
const largeSvg = `
<svg xmlns="http://www.w3.org/2000/svg" width="360" height="90" viewBox="0 0 360 90">
  <defs>
    <linearGradient id="logoGrad-large" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#4361ee" />
      <stop offset="100%" stop-color="#64b5f6" />
    </linearGradient>
  </defs>
  <text
    x="180"
    y="59"
    font-family="'Comic Sans MS', 'Chalkboard SE', 'Marker Felt', cursive"
    font-size="56"
    font-weight="bold"
    text-anchor="middle"
    fill="url(#logoGrad-large)"
    stroke="rgba(15, 23, 42, 0.35)"
    stroke-width="1"
    paint-order="stroke fill"
  >Careerwiki</text>
</svg>
`;

// Small logo SVG
const smallSvg = `
<svg xmlns="http://www.w3.org/2000/svg" width="180" height="40" viewBox="0 0 180 40">
  <defs>
    <linearGradient id="logoGrad-small" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#4361ee" />
      <stop offset="100%" stop-color="#64b5f6" />
    </linearGradient>
  </defs>
  <text
    x="90"
    y="27"
    font-family="'Comic Sans MS', 'Chalkboard SE', 'Marker Felt', cursive"
    font-size="28"
    font-weight="bold"
    text-anchor="middle"
    fill="url(#logoGrad-small)"
    stroke="rgba(15, 23, 42, 0.35)"
    stroke-width="1"
    paint-order="stroke fill"
  >Careerwiki</text>
</svg>
`;

async function generateLogos() {
  try {
    // Generate large logo (2x for retina)
    await sharp(Buffer.from(largeSvg))
      .resize(720, 180) // 2x size for retina
      .png()
      .toFile('./public/static/logo-large.png');
    
    console.log('✓ Generated logo-large.png (720x180)');

    // Generate small logo (2x for retina)
    await sharp(Buffer.from(smallSvg))
      .resize(360, 80) // 2x size for retina
      .png()
      .toFile('./public/static/logo-small.png');
    
    console.log('✓ Generated logo-small.png (360x80)');

    // Also generate 1x versions for fallback
    await sharp(Buffer.from(largeSvg))
      .resize(360, 90)
      .png()
      .toFile('./public/static/logo-large-1x.png');
    
    console.log('✓ Generated logo-large-1x.png (360x90)');

    await sharp(Buffer.from(smallSvg))
      .resize(180, 40)
      .png()
      .toFile('./public/static/logo-small-1x.png');
    
    console.log('✓ Generated logo-small-1x.png (180x40)');

    console.log('\n✅ All logos generated successfully!');
  } catch (error) {
    console.error('Error generating logos:', error);
    process.exit(1);
  }
}

generateLogos();
