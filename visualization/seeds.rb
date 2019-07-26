require 'yaml'
if User.count.zero?
  puts '-- Registering default users'
  YAML.load_file('/run/secrets/accounts')['accounts'].each do |account|
    User.create(login: account['username'], email: account['email'], password: account['password'])
  end
end
