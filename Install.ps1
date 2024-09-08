param (
    [switch]$install,
    [switch]$run,
    [switch]$clean,
    [switch]$help
)

$venvDir = "venv"
$python = "$venvDir\Scripts\python.exe"
$pip = "$venvDir\Scripts\pip.exe"

function New-VirtualEnv {
    if (-Not (Test-Path $venvDir)) {
        Write-Host "Creating virtual environment..."
        python -m venv $venvDir
    } else {
        Write-Host "Virtual environment already exists."
    }
}

function Install-Dependencies {
    Write-Host "Installing dependencies..."
    & $pip install --upgrade pip
    & $pip install -r requirements.txt
}

# Function to run the application
function Invoke-App {
    Write-Host "Running the application..."
    & $python app.pyc
}


function Remove-Environment {
    Write-Host "Cleaning environment..."
    Remove-Item -Recurse -Force $venvDir
    Get-ChildItem -Recurse -Include '__pycache__' | Remove-Item -Recurse -Force
}


function Show-Help {
    Write-Host "PowerShell script for Python app"
    Write-Host "Usage:"
    Write-Host "  .\install.ps1 -install    Install the dependencies from requirements.txt"
    Write-Host "  .\install.ps1 -run        Run the application"
    Write-Host "  .\install.ps1 -clean      Clean the virtual environment and cache files"
    Write-Host "  .\install.ps1 -help       Display this help message"
}


if ($help) {
    Show-Help
} elseif ($clean) {
    Clean-Environment
} else {
    New-VirtualEnv

    if ($install) {
        Install-Dependencies
    }
    if ($run) {
        Invoke-App
    }
}
