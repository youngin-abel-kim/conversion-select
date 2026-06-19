param(
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release",
    [switch]$Clean
)

$ErrorActionPreference = "Stop"

$ProjectName = "conversion-select"
$Source = Join-Path $PSScriptRoot "$ProjectName.cpp"
$BuildDir = Join-Path $PSScriptRoot "build\$Configuration"
$Output = Join-Path $BuildDir "$ProjectName.exe"
$Compiler = if ($env:CXX) { $env:CXX } else { "g++" }

if ($Clean) {
    Remove-Item -Recurse -Force (Join-Path $PSScriptRoot "build") -ErrorAction SilentlyContinue
    exit 0
}

New-Item -ItemType Directory -Force $BuildDir | Out-Null

$CommonFlags = @(
    "-std=c++17",
    "-Wall",
    "-Wextra",
    "-D_CONSOLE"
)

if ($Configuration -eq "Debug") {
    $ConfigFlags = @("-O0", "-g", "-D_DEBUG")
} else {
    $ConfigFlags = @("-O2", "-DNDEBUG")
}

$LinkFlags = @("-limm32")

& $Compiler @CommonFlags @ConfigFlags $Source "-o" $Output @LinkFlags
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host "Built $Output"
