$images = @(
    "assets/quiz/pedestrian_crossing.png",
    "assets/quiz/warning.png",
    "assets/quiz/no_entry.png",
    "assets/quiz/stop_sign.png",
    "assets/quiz/turn_right.png",
    "assets/logistics-bg.png"
)

Add-Type -AssemblyName System.Drawing

foreach ($imagePath in $images) {
    $fullPath = Join-Path $PWD $imagePath
    if (Test-Path $fullPath) {
        Write-Host "Converting $imagePath to JPEG..."
        try {
            # Load the image
            $img = [System.Drawing.Image]::FromFile($fullPath)
            
            # Create new path with .jpg extension
            $jpgPath = $fullPath -replace '\.png$', '.jpg'
            
            # Save as JPEG with high quality
            $qualityEncoder = [System.Drawing.Imaging.Encoder]::Quality
            $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($qualityEncoder, 85L)
            
            $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
            
            $img.Save($jpgPath, $jpegCodec, $encoderParams)
            $img.Dispose()
            
            # Delete original PNG
            Remove-Item $fullPath
            
            $stats = Get-Item $jpgPath
            Write-Host "  Done: $jpgPath ($([math]::Round($stats.Length / 1024))KB)"
        } catch {
            Write-Host "  Failed: $_"
        }
    } else {
        Write-Host "  Not found: $imagePath"
    }
}

Write-Host "`nAll images converted to JPEG format."
