# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count.zero?
  puts '-- added user'
  User.create(login: 'sindan', email: 'sindan@ml.kanazawa-u.ac.jp', password: 'sindan@ml.kanazawa-u.ac.jp')
end
