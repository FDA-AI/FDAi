param(
    [Parameter()]
    [ValidateSet('unit', 'cypress', 'all')]
    [string]$TestType = 'unit',
    [switch]$Build,
    [switch]$Watch
)

$ErrorActionPreference = 'Stop'

function Write-Header {
    param([string]$Message)
    Write-Host "`n=== $Message ===`n" -ForegroundColor Cyan
}

function Run-UnitTests {
    Write-Header "Running PHPUnit Tests"
    $buildFlag = if ($Build) { '--build' } else { '' }
    $cmd = "docker compose -f docker-compose.phpunit.yml up $buildFlag phpunit"
    if ($Watch) {
        $cmd += " --watch"
    }
    Write-Host "Command: $cmd" -ForegroundColor DarkGray
    Invoke-Expression $cmd
}

function Run-CypressTests {
    Write-Header "Running Cypress Tests"
    $buildFlag = if ($Build) { '--build' } else { '' }
    $cmd = "docker compose -f docker-compose.cypress.yml up $buildFlag cypress"
    Write-Host "Command: $cmd" -ForegroundColor DarkGray
    Invoke-Expression $cmd
}

function Clean-Environment {
    Write-Header "Cleaning up test environment"
    docker compose -f docker-compose.phpunit.yml down -v
    docker compose -f docker-compose.cypress.yml down -v
}

function Ensure-Images {
    if (-not (docker images -q dfda-phpunit)) {
        Write-Header "Initial build of PHPUnit image required"
        docker compose -f docker-compose.phpunit.yml build
    }
    if ($TestType -in 'cypress','all' -and -not (docker images -q dfda-cypress)) {
        Write-Header "Initial build of Cypress image required"
        docker compose -f docker-compose.cypress.yml build
    }
}

# Main execution
try {
    Clean-Environment
    Ensure-Images

    switch ($TestType) {
        'unit' { 
            Run-UnitTests 
        }
        'cypress' { 
            Run-CypressTests 
        }
        'all' {
            Run-UnitTests
            Run-CypressTests
        }
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
finally {
    if (-not $Watch) {
        Clean-Environment
    }
} 