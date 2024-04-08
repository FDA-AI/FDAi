# Get all processes named 'node'
$processes = Get-Process -Name node -ErrorAction SilentlyContinue

# Check if there are any running node processes
if ($processes) {
    # Loop through each process
    foreach ($process in $processes) {
        # Log the process ID
        Write-Output "Killing process with ID: $($process.Id)"

        # Kill the process
        Stop-Process -Id $process.Id -Force
    }
} else {
    Write-Output "No node processes found."
}
