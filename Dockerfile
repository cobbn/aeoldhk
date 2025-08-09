# Stage 1: Copy xria from the old base image
FROM reapmr3/reaper-club:latest

# Stage 2: Build a clean Heroku-compatible image
FROM ubuntu:24.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install required base tools for Python builds, GitHub installs, and downloads
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3 \
    python3-pip \
    python3-dev \
    git \
    dos2unix \
    curl \
    wget \
    aria2 \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
