const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const brainDir = 'C:\\Users\\ACER\\.gemini\\antigravity-ide\\brain\\0b7f93a7-8745-4505-940e-b9de485b0e4f';
const horizontalLogoPath = path.join(brainDir, 'media__1785987176538.jpg');
const squareIconPath = path.join(brainDir, 'media__1785987176553.jpg');

const assetsDir = path.join(__dirname, '..', 'assets');

async function processNewAssets() {
  console.log('🖼️ Processing new ProHayat 180 logo & icon assets...');

  // 1. Process horizontal logo.png
  await sharp(horizontalLogoPath)
    .png()
    .toFile(path.join(assetsDir, 'logo.png'));
  console.log('  ✓ Updated assets/logo.png');

  // 2. Process square icon.png
  await sharp(squareIconPath)
    .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
    .png()
    .toFile(path.join(assetsDir, 'icon.png'));
  console.log('  ✓ Updated assets/icon.png');

  // 3. Process adaptive-icon.png
  await sharp(squareIconPath)
    .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
    .png()
    .toFile(path.join(assetsDir, 'adaptive-icon.png'));
  console.log('  ✓ Updated assets/adaptive-icon.png');

  // 4. Process splash-icon.png
  await sharp(squareIconPath)
    .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
    .png()
    .toFile(path.join(assetsDir, 'splash-icon.png'));
  console.log('  ✓ Updated assets/splash-icon.png');

  console.log('🎉 Assets processing complete!');
}

processNewAssets().catch(err => {
  console.error('❌ Error processing assets:', err);
  process.exit(1);
});
