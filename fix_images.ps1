$images = @(
    "assets/logistics-bg.png",
    "assets/quiz/pedestrian_crossing.png",
    "assets/quiz/warning.png",
    "assets/quiz/no_entry.png",
    "assets/quiz/stop_sign.png",
    "assets/quiz/turn_right.png"
)

Add-Type -AssemblyName System.Drawing

foreach ($imagePath in $images) {
    $fullPath = Join-Path $PWD $imagePath
    if (Test-Path $fullPath) {
        Write-Host "Processing $imagePath..."
        try {
            # Load the image
            $img = [System.Drawing.Image]::FromFile($fullPath)
            # Create a new bitmap to clean it (strips metadata/unsupported formats)
            $newImg = new-object System.Drawing.Bitmap($img)
            $img.Dispose()
            
            # Save it back
            $newImg.Save($fullPath, [System.Drawing.Imaging.ImageFormat]::Png)
            $newImg.Dispose()
            
            Write-Host "  ✅ Fixed $imagePath"
        } catch {
            Write-Host "  ❌ Failed to fix $imagePath : $_"
        }
    } else {
        Write-Host "  ⚠️ File not found: $imagePath"
    }
}
