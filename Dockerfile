# build
FROM node:15.4.0-alpine as build-vue
WORKDIR /app
RUN docker login -u evh40836 https://evh40836.live.dynatrace.com
ENV PATH /app/node_modules/.bin:$PATH
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production
FROM nginx:stable-alpine as production
COPY --from=https://evh40836.live.dynatrace.com/linux/oneagent-codemodules-musl:nodejs-python / /
ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so
WORKDIR /app
RUN apk update && apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache
RUN apk update && apk add python3-dev
COPY --from=build-vue /app/dist ./dist
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY .env.sample .
RUN mv .env.sample .env
COPY main.py .

EXPOSE 80
EXPOSE 5000
# Set environment variables for the Flask app
CMD nginx -g 'daemon off;' & python main.py

