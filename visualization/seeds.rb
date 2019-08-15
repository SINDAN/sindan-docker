require 'yaml'
if User.count.zero?
  puts '-- Registering default users'
  YAML.load_file(ENV['ACCOUNTS_FILE'])['accounts'].each do |account|
    User.create(login: account['username'], email: account['email'], password: account['password'])
  end
end
