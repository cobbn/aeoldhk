FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# ✅ Install system build tools required for tgcrypto
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
