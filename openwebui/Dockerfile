ARG BUILD_FROM
FROM ${BUILD_FROM}

# Include build version for better tracking
ARG BUILD_VERSION
LABEL org.opencontainers.image.version="${BUILD_VERSION}"

# Install jq for JSON processing in run.sh
RUN apt-get update && apt-get install -y jq curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create persistent data directory link
RUN mkdir -p /data
RUN rm -rf /app/backend/data && ln -sf /data /app/backend/data

COPY run.sh /
RUN chmod +x /run.sh

# Use our run script instead of the original entrypoint
CMD ["/run.sh"]
