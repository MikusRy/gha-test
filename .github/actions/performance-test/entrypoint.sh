#!/bin/sh
set -e

echo "Starting Docker Daemon..."
dockerd-entrypoint.sh &

# Wait for Docker to be ready
sleep 5

# Set JMeter version
JMETER_VERSION=5.6.2
JMETER_HOME=/opt/apache-jmeter-$JMETER_VERSION
PATH=$JMETER_HOME/bin:$PATH

echo "Running a nested Docker container..."
docker run -dit -p 8080:8080 my-image:latest 

echo "Running JMeter Test..."
jmeter -n -t /app/jmeter.jmx -l /app/results.jtl

echo "JMeter test completed. Results stored in /app/results.jtl"
