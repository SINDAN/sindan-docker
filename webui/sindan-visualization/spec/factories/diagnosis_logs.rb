FactoryBot.define do
  factory :diagnosis_log do
    layer "web"
    log_group "MyText"
    log_type "MyText"
    result :success
    detail "MyText"
    log_campaign_uuid "8D9CEC4B-9A99-4A44-BFDA-445C6765475A"
    occurred_at "2015-07-24 19:24:42"
  end

end
