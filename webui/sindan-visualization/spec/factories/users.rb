FactoryBot.define do
  factory :user, class: User do
    login "name"
    email "user@example.com"
    password "user@example.com"
  end

  factory :login_user, class: User do
    login "login_user"
    email "login_user@example.com"
    password "login_user@example.com"
  end
end
