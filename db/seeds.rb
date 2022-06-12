# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(name: 'Tom', bio: 'Teacher from Mexico', photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg')
second_user = User.create(name: 'Lilly', bio: 'Teacher from Poland', photo: 'https://live.staticflickr.com/65535/52123039595_7631aa7696.jpg')
post = Post.create(author:first_user, title: 'First post', text: 'This is my first post')
post = Post.create(author:first_user, title: 'Second post', text: 'This is my second post')
post = Post.create(author:first_user, title: 'Third post', text: 'This is my third post')
post = Post.create(author:first_user, title: 'Fourth post', text: 'This is my fourth post')
post = Post.first
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')
comment = Comment.create(author: second_user, post: post, text:'Hi Tom!!!')