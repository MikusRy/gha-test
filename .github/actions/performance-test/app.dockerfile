# Use Docker-in-Docker as the base image
FROM docker:dind
RUN apk update

# Set JMeter version
ENV JMETER_VERSION 5.6.2
ENV JMETER_HOME /opt/apache-jmeter-$JMETER_VERSION
ENV PATH $JMETER_HOME/bin:$PATH

# Install JMeter
RUN wget -q "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz" -O /tmp/jmeter.tgz \
    && tar -xzf /tmp/jmeter.tgz -C /opt \
    && rm /tmp/jmeter.tgz

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
