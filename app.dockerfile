# add your code here
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the application script into the container
COPY app.py /app/
COPY requirements.txt

# Install any dependencies (if required, modify this as needed)
# Example: COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Command to run the script
CMD ["python", "app.py"]

