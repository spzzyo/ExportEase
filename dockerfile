# Use Python 3.11 as base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies, including pkg-config, build tools, and MySQL client libraries
RUN apt-get update && apt-get install -y \
    pkg-config \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt into the working directory
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container's working directory
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Set the default command to run the app
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "exportEase.wsgi:application"]
