## requeriments

Build your project schema.
  - Create and run the necessary migration files.
  - Table and column names should match the ERD diagram.
  - note: photo for users table should be a link to an image
  - Foreign keys should be included.
  - All columns that are foreign keys should have a corresponding index.

## to create users table
```
rails g migration CreateUsers Name:string Photo:string Bio:text PostCounter:integer
```
## to create posts table
```
rails g migration CreatePosts author_id:integer Title:string Text:text CommentsCounter:integer LikesCounter:integer
```

Add this to the create_post file before running rake   

```
add_foreign_key :posts, :users, column: :author_id, primary_key: 'id'
add_index :posts, :author_id
```

## to create comments table
```
rails g migration CreateComments author_id:integer post_id:integer Text:text
```

Add this to the create_comments file before running rake

```
add_foreign_key :comments, :users, column: :author_id, primary_key: 'id'
add_foreign_key :comments, :posts
add_index :comments, :author_id
add_index :comments, :post_id
```


## to create likes table

```
rails g migration CreateLikes author_id:integer post_id:integer
```   

Add this to the create_likes file before running rake
   
```
add_foreign_key :likes, :users, column: :author_id, primary_key: 'id'
add_foreign_key :likes, :posts
add_index :likes, :author_id
add_index :likes, :post_id
```