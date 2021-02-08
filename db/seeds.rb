# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email:"user@gmail.com",password:1234)
id_nota=1
(1..5).each do |i|
   book =Book.create(user:user,name:"book #{i}")
   1.upto(4) do |j|
     book.notes.create(title:"nota #{id_nota} de #{book.name}",content: "- lista ", user:user)
     id_nota+=1
   end
 end
 (1..4).each do |h|
    Note.create(user:user,title:"nota-#{id_nota} global", content: "-sin cuaderno")
    id_nota+=1
 end
    