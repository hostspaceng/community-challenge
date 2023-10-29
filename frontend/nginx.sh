#!bin/sh

# Substituting backend application IP into the nginx configuration file
envsubst '$VUE_APP_PROXY_URL' < /etc/nginx/conf.d/nginx.conf.template >  /etc/nginx/conf.d/nginx.conf

# Frontend application sart up command
nginx -g 'daemon off;'
