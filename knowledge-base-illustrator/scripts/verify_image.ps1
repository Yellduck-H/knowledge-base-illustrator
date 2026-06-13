[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ImagePath,

    [string]$BaselinePath,

    [int]$ExpectedWidth = 0,
    [int]$ExpectedHeight = 0,

    [int]$TargetX = -1,
    [int]$TargetY = -1,
    [int]$TargetWidth = 0,
    [int]$TargetHeight = 0,

    [switch]$FailOnDimensionMismatch,
    [switch]$FailOnOutsideTarget
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

function Open-Bitmap {
    param([Parameter(Mandatory = $true)][string]$Path)

    $resolved = (Resolve-Path -LiteralPath $Path).Path
    $source = [System.Drawing.Bitmap]::FromFile($resolved)
    try {
        return [System.Drawing.Bitmap]::new($source)
    }
    finally {
        $source.Dispose()
    }
}

$image = Open-Bitmap -Path $ImagePath
$baseline = $null

try {
    $dimensionMatches = $true
    if ($ExpectedWidth -gt 0 -and $image.Width -ne $ExpectedWidth) {
        $dimensionMatches = $false
    }
    if ($ExpectedHeight -gt 0 -and $image.Height -ne $ExpectedHeight) {
        $dimensionMatches = $false
    }

    $result = [ordered]@{
        image_path = (Resolve-Path -LiteralPath $ImagePath).Path
        format = $image.RawFormat.ToString()
        width = $image.Width
        height = $image.Height
        dimension_matches = $dimensionMatches
        baseline_path = $null
        changed_pixels = $null
        difference_bbox = $null
        target_rect = $null
        outside_target_changed_pixels = $null
    }

    if ($BaselinePath) {
        $baseline = Open-Bitmap -Path $BaselinePath
        if ($baseline.Width -ne $image.Width -or $baseline.Height -ne $image.Height) {
            throw "Image and baseline dimensions differ: $($image.Width)x$($image.Height) vs $($baseline.Width)x$($baseline.Height)."
        }

        $hasTarget = $TargetX -ge 0 -and $TargetY -ge 0 -and $TargetWidth -gt 0 -and $TargetHeight -gt 0
        $targetRight = $TargetX + $TargetWidth
        $targetBottom = $TargetY + $TargetHeight
        $changed = 0L
        $outside = 0L
        $minX = $image.Width
        $minY = $image.Height
        $maxX = -1
        $maxY = -1

        for ($y = 0; $y -lt $image.Height; $y++) {
            for ($x = 0; $x -lt $image.Width; $x++) {
                if ($image.GetPixel($x, $y).ToArgb() -eq $baseline.GetPixel($x, $y).ToArgb()) {
                    continue
                }

                $changed++
                if ($x -lt $minX) { $minX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -gt $maxY) { $maxY = $y }

                if ($hasTarget -and ($x -lt $TargetX -or $x -ge $targetRight -or $y -lt $TargetY -or $y -ge $targetBottom)) {
                    $outside++
                }
            }
        }

        $result.baseline_path = (Resolve-Path -LiteralPath $BaselinePath).Path
        $result.changed_pixels = $changed
        if ($changed -gt 0) {
            $result.difference_bbox = @{
                x = $minX
                y = $minY
                width = $maxX - $minX + 1
                height = $maxY - $minY + 1
            }
        }
        if ($hasTarget) {
            $result.target_rect = @{
                x = $TargetX
                y = $TargetY
                width = $TargetWidth
                height = $TargetHeight
            }
            $result.outside_target_changed_pixels = $outside
        }
    }

    $result | ConvertTo-Json -Depth 4

    if ($FailOnDimensionMismatch -and -not $dimensionMatches) {
        exit 2
    }
    if ($FailOnOutsideTarget -and $null -ne $result.outside_target_changed_pixels -and $result.outside_target_changed_pixels -gt 0) {
        exit 3
    }
}
finally {
    if ($null -ne $baseline) {
        $baseline.Dispose()
    }
    $image.Dispose()
}
