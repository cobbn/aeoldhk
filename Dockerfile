FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY . .

# Create virtual environment and install dependencies inside it
RUN python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    /opt/venv/bin/pip install --no-cache-dir --upgrade pip setuptools && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Run your start.sh with virtualenv activated
CMD ["/bin/bash", "-c", "source /opt/venv/bin/activate && bash start.sh"]
