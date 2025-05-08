ARG BUILD_FROM
FROM ${BUILD_FROM}

# Cleanup and link /app/backend/data to /data for persistence
RUN if [ -d /app/backend/data ]; then rm -rf /app/backend/data; fi \
    && mkdir -p /data && ln -s /data /app/backend/data

# Copy and set permissions for run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
