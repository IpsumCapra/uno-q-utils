FROM uno-q-python-base:0.1.0

WORKDIR /app

# Copy application
COPY . /app

# Optional: install extra dependencies if requirements.txt exists
RUN if [ -s /app/requirements.txt ]; then \
      uv pip install --no-cache -r /app/requirements.txt && \
      rm /app/requirements.txt ; \
    fi

# Expose ports as necessary
# Uncomment to open web ports.
# EXPOSE [80, 443]

# ENTRYPOINT inherited from base image
