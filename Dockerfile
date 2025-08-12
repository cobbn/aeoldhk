FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

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

 RUN ARCH=$(uname -m) && \
    mkdir -p /usr/local/bin && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -qO /usr/local/bin/xnox https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox; \
    elif [ "$ARCH" = "aarch64" ]; then \
        wget -qO /usr/local/bin/xnox https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/aarch64-qbittorrent-nox; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    chmod 700 /usr/local/bin/xnox

COPY requirements.txt .

RUN apt-get remove -y python3-blinker || true

RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
