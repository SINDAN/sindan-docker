require "fluent/plugin/in_http"

module fluent
  class HttpHealthCheckInput < HttpInput
    Fluent::Plugin.register_input('in_http_healthcheck', self)
    def on_request(path_info, params)
      begin
        return ["200 OK", {'Content-Type'=>'text/plain'}, ""]
      end
    end
  end
end
