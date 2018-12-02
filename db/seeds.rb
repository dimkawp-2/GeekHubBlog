# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{name: 'admin', email: 'admin@gmail.com',password: ENV['USER_PASSWORD_ADMIN'],role: 'admin' }])
Post.create([{title: 'Post Title 1', body: 'Just random body text', user_id: 1 },
             {title: 'Post Title 2', body: 'Just random body text' user_id: 1}])
puts 'Success: Seed installs'