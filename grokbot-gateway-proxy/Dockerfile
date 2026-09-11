FROM nginx:1.27-alpine

RUN apk add --no-cache jq

COPY run.sh /run.sh
RUN chmod a+x /run.sh

COPY nginx.conf.template /etc/nginx/templates/default.conf.template

ENTRYPOINT ["/run.sh"]
