require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # before do
  #   # driven_by(:rack_test)
  # end
  before :all do
    @user = User.create(name: 'Victor', photo: '', bio: 'bio',
                        email: 'victorperaltagomez@gmail.com', password: '121212')
    @user.confirm
  end
  after :all do
    @user.destroy
  end

  it 'Can visit log in' do
    visit new_user_session_path
    expect(page).to have_content 'Log in'
  end

  it 'Can log in' do
    log_in
    assert_text 'Signed in successfully.'
  end

  it 'Visit user page' do
    log_in
    visit user_path(id: @user.id)
    expect(page).to have_content @user.name
  end

  private

  def log_in
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'
  end
end
