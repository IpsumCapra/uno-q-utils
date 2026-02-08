FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV UV_SYSTEM_PYTHON=1

# Install uv
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

# Install base wheels
COPY requirements.txt /tmp/requirements.txt
RUN uv pip install --no-cache -r /tmp/requirements.txt

# Install arduino app bricks library
ARG ABL_VERSION=0.7.0
ARG ABL_WHEEL=arduino_app_bricks-${ABL_VERSION}-py3-none-any.whl

RUN curl -L \
  https://github.com/arduino/app-bricks-py/releases/download/release/${ABL_VERSION}/${ABL_WHEEL} \
  -o /tmp/${ABL_WHEEL} \
  && uv pip install --no-cache /tmp/${ABL_WHEEL} \
  && rm /tmp/${ABL_WHEEL}

ENTRYPOINT ["python", "/app/main.py"]
