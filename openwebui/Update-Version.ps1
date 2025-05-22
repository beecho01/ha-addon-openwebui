# Optional parameters - if not provided, script will prompt for values
param(
    [string]$NewVersion,
    [string]$Amd64Sha256,
    [string]$Aarch64Sha256
)

# Function to get input with validation
function Get-ValidInput {
    param (
        [string]$Prompt,
        [string]$DefaultValue,
        [scriptblock]$ValidationScript
    )
    
    if ($DefaultValue) {
        $prompt = "$Prompt [$DefaultValue]"
    }
    
    do {
        $userInput = Read-Host -Prompt $prompt
        
        # Use default if empty
        if ([string]::IsNullOrWhiteSpace($userInput) -and $DefaultValue) {
            $userInput = $DefaultValue
        }
        
        $isValid = $true
        if (![string]::IsNullOrWhiteSpace($userInput) -and $ValidationScript) {
            $isValid = & $ValidationScript $userInput
        } else {
            $isValid = ![string]::IsNullOrWhiteSpace($userInput)
        }
        
        if (-not $isValid) {
            Write-Host "Invalid input. Please try again." -ForegroundColor Red
        }
    } while (-not $isValid)
    
    return $userInput
}

# Get script directory only - we don't need parent directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Get version if not provided
if ([string]::IsNullOrWhiteSpace($NewVersion)) {
    $versionRegex = '^\d+\.\d+\.\d+$'
    $NewVersion = Get-ValidInput -Prompt "Enter the new version (format: x.y.z)" -ValidationScript {
        param($v)
        return $v -match $versionRegex
    }
}

# Get AMD64 SHA if not provided
if ([string]::IsNullOrWhiteSpace($Amd64Sha256)) {
    $shaRegex = '^[0-9a-f]{64}$'
    $Amd64Sha256 = Get-ValidInput -Prompt "Enter the AMD64 SHA256 hash (64 characters)" -ValidationScript {
        param($h)
        return $h -match $shaRegex
    }
}

# Get AARCH64 SHA if not provided
if ([string]::IsNullOrWhiteSpace($Aarch64Sha256)) {
    $shaRegex = '^[0-9a-f]{64}$'
    $Aarch64Sha256 = Get-ValidInput -Prompt "Enter the AARCH64 SHA256 hash (64 characters)" -ValidationScript {
        param($h)
        return $h -match $shaRegex
    }
}

# Confirm inputs
Write-Host "`nPlease confirm these details:" -ForegroundColor Cyan
Write-Host "Version: $NewVersion" -ForegroundColor Green
Write-Host "AMD64 SHA256: $Amd64Sha256" -ForegroundColor Green
Write-Host "AARCH64 SHA256: $Aarch64Sha256" -ForegroundColor Green

$confirm = Read-Host -Prompt "Continue with update? (Y/n)"
if ($confirm -eq "n") {
    Write-Host "Update canceled." -ForegroundColor Yellow
    exit 0
}

# Create version.json content
$versionJson = @{
    version = $NewVersion
    sha256 = @{
        amd64 = $Amd64Sha256
        aarch64 = $Aarch64Sha256
    }
} | ConvertTo-Json -Depth 3

# Create build.json content
$buildJson = @{
    build_from = @{
        amd64 = "ghcr.io/open-webui/open-webui:v$NewVersion@sha256:$Amd64Sha256"
        aarch64 = "ghcr.io/open-webui/open-webui:v$NewVersion@sha256:$Aarch64Sha256"
    }
    labels = @{
        maintainer = "James Beeching (https://github.com/beecho01)"
        "org.opencontainers.image.authors" = "James Beeching (https://github.com/beecho01)"
        "org.opencontainers.image.title" = "Home Assistant Add-on: Open WebUI"
        "org.opencontainers.image.description" = "Home Assistant add-on for Open WebUI — a self-hosted LLM interface."
        "org.opencontainers.image.documentation" = "https://github.com/beecho01/ha-addon-openwebui/README.md"
        "org.opencontainers.image.source" = "https://github.com/beecho01/ha-addon-openwebui"
        "org.opencontainers.image.licenses" = "MIT"
        "org.opencontainers.image.version" = $NewVersion
    }
} | ConvertTo-Json -Depth 3

# Update add-on files only (in current directory)
$versionJsonPath = Join-Path -Path $scriptDir -ChildPath "version.json"
$configPath = Join-Path -Path $scriptDir -ChildPath "config.json"
$buildJsonPath = Join-Path -Path $scriptDir -ChildPath "build.json"

# Update version.json in current directory only
Set-Content -Path $versionJsonPath -Value $versionJson
Write-Host "Updated version.json file" -ForegroundColor Green

# Update build.json in current directory only
Set-Content -Path $buildJsonPath -Value $buildJson
Write-Host "Updated build.json file" -ForegroundColor Green

# Update config.json version
$configJson = Get-Content -Path $configPath -Raw | ConvertFrom-Json
$configJson.version = $NewVersion
$configJson | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath
Write-Host "Updated config.json version" -ForegroundColor Green

Write-Host "`nSuccessfully updated to version $NewVersion" -ForegroundColor Green
Write-Host "Don't forget to update CHANGELOG.md" -ForegroundColor Yellow