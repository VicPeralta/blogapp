class UserInfo
  def initialize(id, name, posts, image)
    @id = id
    @name = name
    @posts = posts
    @image = image
  end

  attr_reader :id, :name, :posts, :image
end
