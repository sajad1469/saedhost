FROM alpine:3.19

RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    socat \
    tzdata \
    sqlite \
    nginx \
    gettext \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

# دانلود و نصب 3x-ui
RUN curl -L https://github.com/rebeccapanel/Rebecca/releases/tag/v1.2.0/rebecca-linux-amd64.tar.gz -o /tmp/rebecca.tar.gz \
    && tar -xzf /tmp/rebecca.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/rebecca/rebecca

RUN mkdir -p /etc/rebecca /var/log/rebecca

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway پورت رو از طریق متغیر $PORT تزریق می‌کند
CMD ["/start.sh"]
