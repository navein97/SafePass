const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const imagesToFix = [
  'assets/logistics-bg.png',
  'assets/quiz/pedestrian_crossing.png',
  'assets/quiz/warning.png',
  'assets/quiz/no_entry.png',
  'assets/quiz/stop_sign.png',
  'assets/quiz/turn_right.png'
];

async function fixImages() {
  for (const imagePath of imagesToFix) {
    const fullPath = path.join(__dirname, imagePath);
    
    if (!fs.existsSync(fullPath)) {
      console.log(`Skipping ${imagePath} - file not found`);
      continue;
    }
    
    const tempPath = fullPath + '.tmp';
    
    try {
      console.log(`Processing ${imagePath}...`);
      
      // Read and re-save the image with proper compression
      await sharp(fullPath)
        .png({ 
          compressionLevel: 9,
          palette: false 
        })
        .toFile(tempPath);
      
      // Replace original with fixed version
      fs.unlinkSync(fullPath);
      fs.renameSync(tempPath, fullPath);
      
      const stats = fs.statSync(fullPath);
      console.log(`  ✓ Fixed ${imagePath} (${Math.round(stats.size / 1024)}KB)`);
    } catch (error) {
      console.error(`  ✗ Error fixing ${imagePath}:`, error.message);
      
      // Clean up temp file if it exists
      if (fs.existsSync(tempPath)) {
        fs.unlinkSync(tempPath);
      }
    }
  }
  
  console.log('\nDone! All images have been processed.');
}

fixImages();
