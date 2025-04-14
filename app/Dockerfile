# Use Python 3.9 as the base image
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /app

# Copy requirements file and install dependencies
# Doing this before copying the app code allows Docker to cache the dependencies
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY src/ .

# Expose the port the app will run on
EXPOSE 5001

# Command to run the application
CMD ["python", "app.py"]