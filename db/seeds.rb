# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a = User.create(fullname: "Steve Alex", fullnameviewable: true, username:"Steveyalex", email: "steve.alex@mail.com", password_digest: "alex", gender: "male", city: "London", cityviewable: true, about:"J")
b = Book.create()
c = Shelf.create(user_id: 1, name: "Reading")
a.shelves << c
c.books << b
s = ShelfBook.create(book_id: b.id, shelf_id: Shelf.all.sample.id) 
d = Review.create(user_id: a.id, shelf_book_id: a.shelves[0].shelf_books.all.sample.id, sentiment: 75, content: "It's okay I guess")
e = Book.create(Client.new("Crime and Punishment").get_search_data[0])

a = Shelf.all[0]
b = Book.create(Client.new("Astrophysics for people in a hurry").get_search_data[0])
