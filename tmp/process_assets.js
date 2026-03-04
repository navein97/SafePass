const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const img1 = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\654ba8d1-337e-427d-8f54-0a896ad7e810\\media__1772596881804.png';
const img2 = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\654ba8d1-337e-427d-8f54-0a896ad7e810\\media__1772589705890.png';
const assetsDir = 'C:\\Users\\ACER\\SafePass\\assets';

async function processImages() {
    try {
        console.log('Processing Icon (1024x1024)...');
        await sharp(img1)
            .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
            .toFile(path.join(assetsDir, 'icon.png'));

        console.log('Processing Adaptive Icon (1024x1024)...');
        // Adaptive icons usually want transparency if the background is defined in app.json, 
        // but we will keep it exactly as the square image provided.
        await sharp(img1)
            .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
            .toFile(path.join(assetsDir, 'adaptive-icon.png'));

        console.log('Processing Favicon (192x192)...');
        await sharp(img1)
            .resize(192, 192)
            .toFile(path.join(assetsDir, 'favicon.png'));

        console.log('Processing Splash Icon (2048x2048)...');
        // Splash icon usually looks best with a smaller logo in the middle of a big canvas
        await sharp(img2)
            .resize({ width: 1200, fit: 'inside' }) // Make the logo a reasonable size in the middle
            .extend({
                top: 724, 
                bottom: 724,
                left: 424,
                right: 424,
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .resize(2048, 2048, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
            .toFile(path.join(assetsDir, 'splash-icon.png'));

        console.log('All images processed successfully!');
    } catch (err) {
        console.error('Error processing images:', err);
        process.exit(1);
    }
}

processImages();
