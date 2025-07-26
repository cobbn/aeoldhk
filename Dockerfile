FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
# Create virtual environment
RUN uv venv
# Install Python dependencies
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt
# Copy app source
COPY . .
# Run your app
CMD ["bash", "start.sh"]
