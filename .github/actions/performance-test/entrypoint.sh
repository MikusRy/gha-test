#!/bin/sh
set -e

echo "Starting Docker Daemon..."
dockerd-entrypoint.sh &

# Wait for Docker to be ready
sleep 5

echo "Running a nested Docker container..."
docker run -dit -p 8080:8080 my-image:latest 

echo "Running JMeter Test..."
jmeter -n -t /app/jmeter.jmx -l /app/results.jtl

echo "JMeter test completed. Results stored in /app/results.jtl"
