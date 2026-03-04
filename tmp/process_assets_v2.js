const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const imgNewSquare = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\654ba8d1-337e-427d-8f54-0a896ad7e810\\media__1772617544062.png';
const imgSplashSource = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\654ba8d1-337e-427d-8f54-0a896ad7e810\\media__1772589705890.png';
const assetsDir = 'C:\\Users\\ACER\\SafePass\\assets';

async function processImages() {
    try {
        console.log('Processing Icon (1024x1024) from NEW design...');
        await sharp(imgNewSquare)
            .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
            .toFile(path.join(assetsDir, 'icon.png'));

        console.log('Processing Adaptive Icon (1024x1024) from NEW design...');
        await sharp(imgNewSquare)
            .resize(1024, 1024, { fit: 'contain', background: { r: 255, g: 255, b: 255, alpha: 1 } })
            .toFile(path.join(assetsDir, 'adaptive-icon.png'));

        console.log('Processing Favicon (192x192) from NEW design...');
        await sharp(imgNewSquare)
            .resize(192, 192)
            .toFile(path.join(assetsDir, 'favicon.png'));

        // Keeping the splash as it was (from the landscape logo) unless you want it changed
        console.log('All icons updated with the latest design!');
    } catch (err) {
        console.error('Error processing images:', err);
        process.exit(1);
    }
}

processImages();
