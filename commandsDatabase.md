## requeriments

Build your project schema.
  - Create and run the necessary migration files.
  - Table and column names should match the ERD diagram.
  - note: photo for users table should be a link to an image
  - Foreign keys should be included.
  - All columns that are foreign keys should have a corresponding index.

## to create users table
```
rails g migration CreateUsers Name:string Photo:string Bio:string PostCounter:integer
```
## to create posts table
```
rails g migration CreatePosts user_id:integer Title:string Text:string CommentsCounter:integer LikesCounter:integer
```

Add this to the create_post file before running rake   

```
add_foreign_key :posts, :users
```

## to create comments table
```
rails g migration CreateComments user_id:integer post_id:integer Text:string
```

Add this to the create_comments file before running rake

```
add_foreign_key :comments, :users
add_foreign_key :comments, :posts
add_index :comments, :user_id
add_index :comments, :post_id
```


## to create likes table

```
rails g migration CreateLikes user_id:integer post_id:integer
```   

Add this to the create_likes file before running rake
   
```
add_foreign_key :likes, :users
add_foreign_key :likes, :posts
add_index :likes, :user_id
add_index :likes, :post_id
```