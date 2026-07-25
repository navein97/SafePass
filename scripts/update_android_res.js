const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const projectRoot = path.join(__dirname, '..');
const assetsDir = path.join(projectRoot, 'assets');
const resDir = path.join(projectRoot, 'android', 'app', 'src', 'main', 'res');

const iconSource = path.join(assetsDir, 'icon.png');
const adaptiveSource = path.join(assetsDir, 'adaptive-icon.png');
const splashSource = path.join(assetsDir, 'splash-icon.png');

const mipmapConfig = [
  { dir: 'mipmap-mdpi', size: 48, fgSize: 108 },
  { dir: 'mipmap-hdpi', size: 72, fgSize: 162 },
  { dir: 'mipmap-xhdpi', size: 96, fgSize: 216 },
  { dir: 'mipmap-xxhdpi', size: 144, fgSize: 324 },
  { dir: 'mipmap-xxxhdpi', size: 192, fgSize: 432 },
];

const splashConfig = [
  { dir: 'drawable-mdpi', size: 128 },
  { dir: 'drawable-hdpi', size: 192 },
  { dir: 'drawable-xhdpi', size: 256 },
  { dir: 'drawable-xxhdpi', size: 384 },
  { dir: 'drawable-xxxhdpi', size: 512 },
];

async function updateResources() {
  console.log('🔄 Updating Android mipmap launcher icons...');
  for (const item of mipmapConfig) {
    const targetFolder = path.join(resDir, item.dir);
    if (!fs.existsSync(targetFolder)) {
      fs.mkdirSync(targetFolder, { recursive: true });
    }

    // ic_launcher.webp
    await sharp(iconSource)
      .resize(item.size, item.size)
      .webp({ quality: 100 })
      .toFile(path.join(targetFolder, 'ic_launcher.webp'));

    // ic_launcher_round.webp
    await sharp(iconSource)
      .resize(item.size, item.size)
      .webp({ quality: 100 })
      .toFile(path.join(targetFolder, 'ic_launcher_round.webp'));

    // ic_launcher_foreground.webp
    await sharp(adaptiveSource)
      .resize(item.fgSize, item.fgSize)
      .webp({ quality: 100 })
      .toFile(path.join(targetFolder, 'ic_launcher_foreground.webp'));

    console.log(`  ✓ Updated ${item.dir}`);
  }

  console.log('🔄 Updating Android splashscreen logos...');
  for (const item of splashConfig) {
    const targetFolder = path.join(resDir, item.dir);
    if (!fs.existsSync(targetFolder)) {
      fs.mkdirSync(targetFolder, { recursive: true });
    }

    // splashscreen_logo.png
    await sharp(splashSource)
      .resize(item.size, item.size, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
      .png()
      .toFile(path.join(targetFolder, 'splashscreen_logo.png'));

    console.log(`  ✓ Updated ${item.dir}`);
  }

  console.log('✅ Android resources updated successfully!');
}

updateResources().catch(err => {
  console.error('❌ Error updating resources:', err);
  process.exit(1);
});
