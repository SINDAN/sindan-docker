FROM grafana/grafana:11.1.0
LABEL org.opencontainers.image.source https://github.com/SINDAN/sindan-docker

USER root

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER grafana

COPY ./provisioning /etc/grafana/provisioning
COPY ./config.ini /etc/grafana/config.ini
COPY ./dashboards /var/lib/grafana/dashboards

ENTRYPOINT /entrypoint.sh

