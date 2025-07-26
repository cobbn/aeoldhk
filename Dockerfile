FROM reapmr3/reaper-club:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN uv venv
COPY requirements.txt .

RUN apt-get update && apt-get install -y gcc python3-dev

RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .
CMD ["bash", "start.sh"]
