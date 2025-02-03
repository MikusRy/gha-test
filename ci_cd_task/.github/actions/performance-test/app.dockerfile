# Use Docker-in-Docker as the base image
FROM docker:dind

# Install JMeter
RUN apk add --no-cache openjdk11-jre wget unzip \
    && wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.2.tgz \
    && tar -xzf apache-jmeter-5.6.2.tgz -C /opt \
    && rm apache-jmeter-5.6.2.tgz

# Set environment variables for JMeter
ENV JMETER_HOME /opt/apache-jmeter-5.6.2
ENV PATH $JMETER_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Copy JMeter test plan
COPY jmeter.jmx /app/test.jmx

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]