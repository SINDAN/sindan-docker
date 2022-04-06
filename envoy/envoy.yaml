static_resources:
  listeners:
  - name: listener_80
    address:
      socket_address:
        address: 0.0.0.0
        port_value: 80
    filter_chains:
    - filters:
      - name: envoy.filters.network.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          stat_prefix: ingress_http
          codec_type: AUTO
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains:
              - "*"
              routes:
              - match:
                  prefix: "/.well-known/acme-challenge"
                route:
                  cluster: certbot_nginx
              - match:
                  prefix: "/"
                redirect:
                  https_redirect: true
          http_filters:
          - name: envoy.filters.http.router

  - name: listener_443
    address:
      socket_address:
        address: 0.0.0.0
        port_value: 443
    filter_chains:
    - filters:
      - name: envoy.filters.network.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          stat_prefix: ingress_http
          codec_type: AUTO
          route_config:
            name: local_route
            virtual_hosts:
            - name: local_service
              domains:
              - "*"
              routes:
              - match:
                  prefix: "/.well-known/acme-challenge"
                route:
                  cluster: certbot_nginx
              - match:
                  prefix: "/"
                route:
                  host_rewrite_literal: sindan.sindan-net.com
                  cluster: certbot_nginx
          http_filters:
          - name: envoy.filters.http.router
      transport_socket:
        name: envoy.transport_sockets.tls
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.DownstreamTlsContext
          common_tls_context:
            tls_certificates:
            - certificate_chain:
                filename: /etc/envoy/certs/live/sindan.sindan-net.com/fullchain.pem
              private_key:
                filename: /etc/envoy/certs/live/sindan.sindan-net.com/privkey.pem

  clusters:
  - name: certbot_nginx
    connect_timeout: 1s
    type: LOGICAL_DNS
    dns_lookup_family: V4_ONLY
    lb_policy: ROUND_ROBIN
    load_assignment:
      cluster_name: certbot_nginx
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: certbot-nginx
                port_value: 80

  - name: nginx
    connect_timeout: 1s
    type: LOGICAL_DNS
    dns_lookup_family: V4_ONLY
    lb_policy: ROUND_ROBIN
    load_assignment:
      cluster_name: nginx
      endpoints:
      - lb_endpoints:
        - endpoint:
            address:
              socket_address:
                address: nginx
                port_value: 80
