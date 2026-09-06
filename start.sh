#!/bin/bash
set -e

echo "🚀 Starting rebecca + nginx reverse proxy..."

# nginx همیشه روی پورت ثابت 7000 گوش می‌دهد
export NGINX_PORT=7000

cd /usr/local/rebecca

echo "🔧 Applying panel settings via x-ui CLI..."
./rebecca setting -port 2053 -webBasePath /managepanel/ || true

echo "🔧 Building nginx.conf for fixed port: $NGINX_PORT"
envsubst '${NGINX_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "▶️  Starting x-ui in background..."
./rebecca &
X_UI_PID=$!

sleep 2

echo "▶️  Starting nginx in foreground on port $NGINX_PORT..."
nginx -t
exec nginx -g "daemon off;"
