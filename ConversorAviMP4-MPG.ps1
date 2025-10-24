# Extensiones que quieres convertir
$extensiones = @("*.avi", "*.mpg")

foreach ($ext in $extensiones) {
    # Recorre todos los archivos con la extensión actual
    Get-ChildItem -Filter $ext | ForEach-Object {
        $input = $_.FullName
        $output = "$($_.DirectoryName)\$($_.BaseName).mp4"

        Write-Host "Convirtiendo: $($_.Name) → $($_.BaseName).mp4" -ForegroundColor Cyan

        ffmpeg -i "$input" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "$output"

        if (Test-Path "$output") {
            Write-Host "Conversión completada: $($_.BaseName).mp4" -ForegroundColor Green

            # Si quieres eliminar el original al terminar:
            # Remove-Item "$input" -Force
        } else {
            Write-Host "Error al convertir: $($_.Name)" -ForegroundColor Red
        }
    }
}

