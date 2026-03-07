const sharp = require('sharp');
const path = require('path');

const ROOT = path.join(__dirname, '..');
const ANDROID_RES = path.join(ROOT, 'android', 'app', 'src', 'main', 'res');

// Source images
const ICON_SRC = path.join(ROOT, 'assets', 'icon.png');
const ADAPTIVE_SRC = path.join(ROOT, 'assets', 'adaptive-icon.png');
const SPLASH_SRC = path.join(ROOT, 'assets', 'splash-icon.png');

// Icon sizes per density bucket
const DENSITIES = [
  { folder: 'mipmap-mdpi',    size: 48,  foreground: 108 },
  { folder: 'mipmap-hdpi',    size: 72,  foreground: 162 },
  { folder: 'mipmap-xhdpi',   size: 96,  foreground: 216 },
  { folder: 'mipmap-xxhdpi',  size: 144, foreground: 324 },
  { folder: 'mipmap-xxxhdpi', size: 192, foreground: 432 },
];

// Splash screen sizes per density bucket
const SPLASH_DENSITIES = [
  { folder: 'drawable-mdpi',    width: 128, height: 128 },
  { folder: 'drawable-hdpi',    width: 192, height: 192 },
  { folder: 'drawable-xhdpi',   width: 256, height: 256 },
  { folder: 'drawable-xxhdpi',  width: 384, height: 384 },
  { folder: 'drawable-xxxhdpi', width: 512, height: 512 },
];

// Notification icon sizes (Android requires white-on-transparent)
const NOTIFICATION_DENSITIES = [
  { folder: 'drawable-mdpi',    size: 24 },
  { folder: 'drawable-hdpi',    size: 36 },
  { folder: 'drawable-xhdpi',   size: 48 },
  { folder: 'drawable-xxhdpi',  size: 72 },
  { folder: 'drawable-xxxhdpi', size: 96 },
];

async function updateIcons() {
  // --- Update App Icons ---
  console.log('🎨 Updating Android app icons...\n');

  for (const { folder, size, foreground } of DENSITIES) {
    const dir = path.join(ANDROID_RES, folder);

    await sharp(ICON_SRC).resize(size, size).webp({ quality: 100 }).toFile(path.join(dir, 'ic_launcher.webp'));
    console.log(`✓ ${folder}/ic_launcher.webp (${size}x${size})`);

    await sharp(ICON_SRC).resize(size, size).webp({ quality: 100 }).toFile(path.join(dir, 'ic_launcher_round.webp'));
    console.log(`✓ ${folder}/ic_launcher_round.webp (${size}x${size})`);

    await sharp(ADAPTIVE_SRC).resize(foreground, foreground).webp({ quality: 100 }).toFile(path.join(dir, 'ic_launcher_foreground.webp'));
    console.log(`✓ ${folder}/ic_launcher_foreground.webp (${foreground}x${foreground})\n`);
  }

  console.log('✅ Done! All icons updated.\n');

  // --- Update Splash Screen ---
  console.log('🌅 Updating splash screen images...\n');

  for (const { folder, width, height } of SPLASH_DENSITIES) {
    const dest = path.join(ANDROID_RES, folder, 'splashscreen_logo.png');
    await sharp(SPLASH_SRC)
      .resize(width, height, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 0 } })
      .png()
      .toFile(dest);
    console.log(`✓ ${folder}/splashscreen_logo.png (${width}x${height})`);
  }

  // --- Update Notification Icons ---
  console.log('\n🔔 Updating notification icons...\n');

  for (const { folder, size } of NOTIFICATION_DENSITIES) {
    const dest = path.join(ANDROID_RES, folder, 'notification_icon.png');

    // Step 1: Resize the source icon
    const resizedBuf = await sharp(ICON_SRC)
      .resize(size, size, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 255 } })
      .png()
      .toBuffer();

    // Step 2: Create a black-and-white shape mask
    // We flatten onto white, turn it grayscale, then invert it (so the white background becomes black/transparent)
    // Then threshold it so the logo shape becomes pure white (fully opaque)
    const maskBuf = await sharp(resizedBuf)
      .flatten({ background: '#ffffff' })
      .greyscale()
      .negate()
      .threshold(30)
      .toColorspace('b-w')
      .png()
      .toBuffer();

    // Step 3: Create a solid white canvas and apply the shape mask as the alpha channel
    await sharp({
      create: { width: size, height: size, channels: 3, background: { r: 255, g: 255, b: 255 } }
    })
      .joinChannel(maskBuf) // Use the black/white mask as the transparency channel
      .png()
      .toFile(dest);

    console.log(`✓ ${folder}/notification_icon.png (${size}x${size})`);
  }

  console.log('\n✅ Done! All icons, splash screen, and notification icon updated.');
  console.log('\nNow run:');
  console.log('  cd android && .\\gradlew assembleRelease');
}

updateIcons().catch(err => {
  console.error('❌ Error:', err.message);
  process.exit(1);
});
