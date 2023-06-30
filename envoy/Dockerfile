FROM envoyproxy/envoy:v1.26-latest
LABEL maintainer "SINDAN WG <sindan-wg@wide.ad.jp>"
LABEL org.opencontainers.image.source https://github.com/SINDAN/sindan-docker

COPY envoy.yaml /etc/envoy/envoy.yaml
RUN chmod go+r /etc/envoy/envoy.yaml
