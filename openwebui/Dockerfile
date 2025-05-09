ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN mkdir -p /data /app/backend \
    && ln -sfn /data /app/backend/data

RUN if ! command -v openssl >/dev/null 2>&1 ; then \
      (command -v apk && apk add --no-cache openssl) || \
      (command -v apt-get && apt-get update && apt-get install -y --no-install-recommends openssl && rm -rf /var/lib/apt/lists/*) ; \
    fi

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
