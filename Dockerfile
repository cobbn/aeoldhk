# Use Ubuntu 24.04 LTS (Heroku stack base) instead of whatever was in reapmr3/reaper-club
FROM ubuntu:24.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install required base tools for Python builds and downloads
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3 \
    python3-pip \
    python3-dev \
    dos2unix \
    curl \
    wget \
    aria2 \
 && rm -rf /var/lib/apt/lists/*

# Optional: Copy xria from your old image if it's custom
# COPY --from=reapmr3/reaper-club:latest /usr/local/bin/xria /usr/local/bin/xria
# RUN chmod +x /usr/local/bin/xria

# Verify aria2 is available
RUN echo "=== Verifying aria2 availability ===" && \
    which aria2c && aria2c --version

COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
