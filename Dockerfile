FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Check what's available in the base image
RUN echo "=== Checking base image ===" && \
    which xria || echo "xria not found" && \
    which aria2c || echo "aria2c not found" && \
    which aria2 || echo "aria2 not found" && \
    ls -la /usr/bin/ | grep aria || echo "No aria binaries found"

# Install build dependencies for compiling Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    dos2unix \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Verify xria is available (since it should be in the base image)
RUN echo "=== Verifying xria availability ===" && \
    which xria && xria --version

COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
