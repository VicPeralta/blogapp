## to create users table
```
rails g migration CreateUsers name:string photo:string bio:string postCounter:integer
```
## to create posts table
```
rails g migration CreatePosts user_id:integer title:string Text:string CommentsCounter:integer LikesCounter:integer
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
```


## to create likes table

```
rails g migration CreateLikes user_id:integer post_id:integer
```   

Add this to the create_likes file before running rake
   
```
add_foreign_key :likes, :users
add_foreign_key :likes, :posts
```