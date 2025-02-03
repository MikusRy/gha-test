#!/bin/sh
set -e

echo "Starting Docker Daemon..."
dockerd-entrypoint.sh &

# Wait for Docker to be ready
sleep 5

echo "Running a nested Docker container..."
docker run --rm busybox echo "Inside the nested container"

echo "Running JMeter Test..."
jmeter -n -t /app/test.jmx -l /app/results.jtl

echo "JMeter test completed. Results stored in /app/results.jtl"

# Execute additional commands if provided
exec "$@"