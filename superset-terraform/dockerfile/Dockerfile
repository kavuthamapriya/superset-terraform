# Python base image
FROM python:3.9-slim

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev libssl-dev \
    libffi-dev libxml2-dev libxslt1-dev zlib1g-dev \
    && apt-get clean

# Set working directory
WORKDIR /app


# Copy requirements and install the dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy Superset configuration
COPY superset_config.py /root/.superset/superset_config.py

# Copy .env file for environment variables
COPY .env /app/.env

# Install python-dotenv to load .env variables
RUN pip install python-dotenv

# Expose Superset port
EXPOSE 8088

# Set environment variables for admin credentials
ENV SUPERSET_ADMIN_USERNAME
ENV SUPERSET_ADMIN_PASSWORD
ENV SUPERSET_ADMIN_EMAIL

# Database migration, Admin user creation, Initialize Superset
RUN superset db upgrade && \
    superset fab create-admin --username $SUPERSET_ADMIN_USERNAME --firstname Admin --lastname User --email $SUPERSET_ADMIN_EMAIL --password $SUPERSET_ADMIN_PASSWORD && \
    superset init

# Start Superset
CMD ["superset", "run", "-h", "0.0.0.0", "-p", "8088", "--with-threads", "--reload", "--debugger"]
