# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email:"user@gmail.com",password:1234)
(1..8).each do |i|
   book =Book.create(user:user,name:"book #{i}")
   1.upto(rand(1..5)) do |j|
     book.notes.create(title:"nota-#{j}",content: "- lista ", user:user)
   end
 end
 (1..10).each do |i|
    Note.create(user:user,title:"nota-sin", content: "- nota sin cuaderno")
 end
    