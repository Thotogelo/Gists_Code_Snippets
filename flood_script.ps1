flood_script.ps1param(
    [string]$Endpoint = "http://example.org/queue/send",
    [int]$Iterations = 5000 #Change as required
)

# Define the base request body (no MSISDN field)
$BaseBody = @{
    uid = 2
    hdapsuccess = $true
    updateDBSuccess = $true
    message = ""
}

# Set headers for JSON content
$Headers = @{
    "Content-Type" = "application/json"
}

Write-Host "Sending requests to $Endpoint for $Iterations iterations..." -ForegroundColor Yellow

for ($i = 1; $i -le $Iterations; $i++) {
    # Clone the base body for each request
    $CurrentBody = $BaseBody.Clone()

    # Convert to JSON
    $JsonBody = $CurrentBody | ConvertTo-Json -Depth 4

    try {
        # Use Invoke-WebRequest to get status code information
        $response = Invoke-WebRequest -Uri $Endpoint -Method Post -Headers $Headers -Body $JsonBody -ErrorAction Stop
        Write-Host "Request $i: Success (Status code: $($response.StatusCode))" -ForegroundColor Green
    }
    catch {
        if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
            Write-Host "Request $i: Failed (Status code: $($_.Exception.Response.StatusCode)) - $($_.Exception.Message)" -ForegroundColor Red
        }
        else {
            Write-Host "Request $i: Failed - $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "All requests completed." -ForegroundColor Cyan
