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
end
