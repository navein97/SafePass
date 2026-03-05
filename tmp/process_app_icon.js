const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const inputImagePath = 'C:\\Users\\ACER\\.gemini\\antigravity\\brain\\d2cc8a57-7cc1-4e14-9d86-b974bb1eb66d\\driver360_app_icon_1772703395546.png';
const assetsDir = path.join(__dirname, '..', 'assets');

async function processIcon() {
    console.log('Starting icon processing...');
    
    // Ensure input file exists
    if (!fs.existsSync(inputImagePath)) {
        console.error('Input image not found at:', inputImagePath);
        return;
    }

    try {
        // Standard icon (1024x1024) - white background
        await sharp(inputImagePath)
            .resize(1024, 1024, {
                fit: 'contain',
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .toFile(path.join(assetsDir, 'icon.png'));
        console.log('✅ Generated icon.png (1024x1024)');

        // Adaptive icon (1024x1024) - white background
        await sharp(inputImagePath)
            .resize(1024, 1024, {
                fit: 'contain',
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .toFile(path.join(assetsDir, 'adaptive-icon.png'));
        console.log('✅ Generated adaptive-icon.png (1024x1024)');

        console.log('All icons generated successfully!');
    } catch (error) {
        console.error('Error generating icons:', error);
    }
}

processIcon();
