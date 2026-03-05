const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const dirPath = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\d2cc8a57-7cc1-4e14-9d86-b974bb1eb66d';
const assetsDir = path.join(__dirname, '..', 'assets');

async function processSplash() {
    try {
        console.log('Finding latest image...');
        const files = fs.readdirSync(dirPath);
        const mediaFiles = files
            .filter(f => f.startsWith('media__') && f.endsWith('.png'))
            .sort() // ascending
            .reverse(); // newest first
        
        if (mediaFiles.length === 0) {
            console.error('No media files found');
            return;
        }

        const inputImagePath = path.join(dirPath, mediaFiles[0]);
        console.log('Using image:', inputImagePath);

        // 1. Trim the image to strictly its content to remove built-in padding
        // Using a moderate threshold to remove pure white/transparent backgrounds
        let trimmedBuffer = await sharp(inputImagePath)
            .trim({ threshold: 40 })
            .toBuffer();
        
        const metadata = await sharp(trimmedBuffer).metadata();
        console.log(`Trimmed size: ${metadata.width}x${metadata.height}`);

        // 2. We want the image to be "big and clear" on the splash screen.
        // Screen sizes vary, but a 1242x2436 canvas with high-density logo represents standard Expo splash shapes well.
        // We will make the canvas 2048x2048 to ensure high quality and prevent Expo from clipping on weird aspect ratios.
        // Let's create a 2048x2048 transparent canvas, but center the logo taking up 90% of it.
        const canvasWidth = 2048;
        const canvasHeight = 2048;
        
        // This makes it look massive and clear.
        const logoTargetWidth = Math.floor(canvasWidth * 0.90); 

        let resizedLogoBuffer = await sharp(trimmedBuffer)
            .resize({ width: logoTargetWidth })
            .toBuffer();

        // 3. Composite over a transparent background, keeping the original white background of the image intact but giving it minimal padding
        await sharp({
            create: {
                width: canvasWidth,
                height: canvasHeight,
                channels: 4,
                background: { r: 255, g: 255, b: 255, alpha: 0 } // transparent
            }
        })
        .composite([{ input: resizedLogoBuffer, gravity: 'center' }])
        .png()
        .toFile(path.join(assetsDir, 'splash-icon.png'));

        console.log('✅ Generated splash-icon.png with maximized width!');
    } catch (e) {
        console.error('Error generating splash:', e);
    }
}

processSplash();
