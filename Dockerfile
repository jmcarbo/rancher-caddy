#FROM ubuntu
#RUN apt-get update && apt-get install -y curl wget vim jq
#ADD https://github.com/containous/traefik/releases/download/v1.0.0-beta.280/traefik_linux-amd64 /usr/local/bin/traefik
#RUN chmod +x /usr/local/bin/traefik
#ADD https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 /usr/local/bin/confd
#RUN chmod +x /usr/local/bin/confd
#RUN bash -c 'mkdir -p /etc/confd/{conf.d,templates}'
#ADD confd.toml /etc/confd/conf.d/confd.toml
#ADD traefik.toml.tmpl /etc/confd/templates/traefik.toml.tmpl
#ADD certificates.sh.tmpl /etc/confd/templates/certificates.sh.tmpl
#ADD start.sh /start.sh
#RUN chmod +x /start.sh
#ADD gosuv /usr/local/bin/gosuv
#RUN chmod +x /usr/local/bin/gosuv
#ADD get_certificates.sh /usr/local/bin/get_certificates.sh
#RUN chmod +x /usr/local/bin/get_certificates.sh
#ADD dummy.crt /etc/certs/dummy.crt
#ADD dummy.key /etc/certs/dummy.key
#ADD https://dl.minio.io/client/mc/release/linux-amd64/mc /usr/local/bin/mc
#RUN chmod +x /usr/local/bin/mc
#CMD "/start.sh"
#VOLUME "/acme"

FROM alpine:edge
MAINTAINER ZZROT LLC <docker@zzrot.com>

RUN apk --no-cache add tini git \
    && apk --no-cache add --virtual devs tar curl

#Install Caddy Server, and All Middleware
RUN curl "https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors,git,hugo,ipfilter,jsonp,jwt,mailout,prometheus,realip,search,upload" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

ADD https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
ADD start /start
RUN chmod +x /start
ADD files/gosuv /usr/local/bin/gosuv
RUN chmod +x /usr/local/bin/gosuv
RUN mkdir /etc/confd
RUN mkdir /etc/confd/conf.d
RUN mkdir /etc/confd/templates
ADD files/confd.toml /etc/confd/conf.d/confd.toml
ADD files/Caddyfile.tmpl /etc/confd/templates/Caddyfile.tmpl

#Remove build devs
RUN apk del devs

#Copy over a default Caddyfile
COPY ./Caddyfile /etc/Caddyfile

#USER caddy

ENTRYPOINT ["tini"]

#CMD ["caddy", "--conf", "/etc/Caddyfile"]
CMD ["/start"]
