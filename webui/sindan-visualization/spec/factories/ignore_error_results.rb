FactoryBot.define do
  factory :ignore_error_result do
    ssid "MySSID"
    ignore_log_types %w( v4http_srv )
  end
end
