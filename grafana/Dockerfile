#FROM grafana/grafana:6.5.0-beta1
FROM grafana/grafana:6.5.0
ADD ./provisioning /etc/grafana/provisioning
ADD ./config.ini /etc/grafana/config.ini
ADD ./dashboards /var/lib/grafana/dashboards
