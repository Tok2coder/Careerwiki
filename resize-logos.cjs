const sharp = require('sharp');

async function resizeLogos() {
  try {
    // Small logos (180x40 and 360x80)
    await sharp('./public/static/logo-temp-1.png')
      .resize(180, 40, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile('./public/static/logo-small-1x.png');
    console.log('✓ Generated logo-small-1x.png (180x40)');

    await sharp('./public/static/logo-temp-1.png')
      .resize(360, 80, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile('./public/static/logo-small.png');
    console.log('✓ Generated logo-small.png (360x80)');

    // Large logos (360x90 and 720x180)
    await sharp('./public/static/logo-temp-2.png')
      .resize(360, 90, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile('./public/static/logo-large-1x.png');
    console.log('✓ Generated logo-large-1x.png (360x90)');

    await sharp('./public/static/logo-temp-2.png')
      .resize(720, 180, { fit: 'contain', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile('./public/static/logo-large.png');
    console.log('✓ Generated logo-large.png (720x180)');

    console.log('\n✅ All logos resized successfully!');
  } catch (error) {
    console.error('Error resizing logos:', error);
    process.exit(1);
  }
}

resizeLogos();
