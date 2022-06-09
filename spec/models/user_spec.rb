require 'rails_helper'

RSpec.describe 'User model', type: :request do
  it 'Create valid user' do
    user = User.new(name: 'Victor', photo: 'url', bio: 'Programmer', postCounter: 0)
    expect(user).to be_valid
  end

  it 'Create invalid user due to empty name' do
    user = User.new(name: '', photo: 'url', bio: 'Programmer', postCounter: 0)
    expect(user).to_not be_valid
    expect(user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Expect right error message due to empty name' do
    user = User.new(name: '', photo: 'url', bio: 'Programmer', postCounter: 0)
    expect(user).to_not be_valid
    expect(user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Create invalid user due to missing postCounter' do
    user = User.new(name: 'Victor', photo: 'url', bio: 'Programmer')
    expect(user).to_not be_valid
  end

  it 'Create invalid user due to wrong postCounter value' do
    user = User.new(name: 'Victor', photo: 'url', bio: 'Programmer', postCounter: -1)
    expect(user).to_not be_valid
  end

  it 'Expect right error message due to wrong postCounter value' do
    user = User.new(name: 'Victor', photo: 'url', bio: 'Programmer', postCounter: -1)
    expect(user).to_not be_valid
    expect(user.errors[:postCounter][0]).to be == 'postCounter must be integer and >=0'
  end

  it 'Expect the three most recent posts for the first user (Instance method)' do
    user = User.first
    posts = user.three_most_recent_posts
    expect(posts.size).to be == 3
    expect(posts[0].id).to be == 4
  end

  it 'Expect the three most recent posts for the first user (Class method)' do
    user = User.first
    posts = User.three_most_recent_posts(user)
    expect(posts.size).to be == 3
    expect(posts[0].id).to be == 4
  end
end
