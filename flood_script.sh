#!/bin/bash

# Default values
Endpoint="http://example.org/queue/send"
Iterations=5000  # Change as required

# Parse command-line arguments
while getopts "e:n:" opt; do
  case ${opt} in
    e )
      Endpoint="$OPTARG"
      ;;
    n )
      Iterations="$OPTARG"
      ;;
    \? )
      echo "Usage: $0 [-e endpoint] [-n iterations]"
      exit 1
      ;;
  esac
done

# Define the base request body as a JSON string
BaseBody='{
    "uid": 2,
    "hdapsuccess": true,
    "updateDBSuccess": true,
    "message": ""
}'

# Set header for JSON content
Header="Content-Type: application/json"

# Write initial message with yellow color
echo -e "\e[33mSending requests to $Endpoint for $Iterations iterations...\e[0m"

# For loop
for ((i=1; i<=Iterations; i++)); do
    # Send POST request using curl
    status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "$Header" -d "$BaseBody" "$Endpoint")
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        if [ "$status_code" -ge 200 ] && [ "$status_code" -lt 300 ]; then
            echo -e "\e[32mRequest $i: Success (Status code: $status_code)\e[0m"
        else
            echo -e "\e[31mRequest $i: Failed (Status code: $status_code)\e[0m"
        fi
    else
        echo -e "\e[31mRequest $i: Failed (Curl error code: $exit_code)\e[0m"
    fi
done

# Write completion message with cyan color
echo -e "\e[36mAll requests completed.\e[0m"
