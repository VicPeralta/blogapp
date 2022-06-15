require 'rails_helper'

describe 'the signin process', type: :feature do
  before :all do
    @user ||= User.create(
    name:'Tom',
    photo: 'https://live.staticflickr.com/65535/52122569383_698a119861_z.jpg',
    bio: 'A teacher from Mexico',
    email: 'victorperaltagomez@gmail.com',
    password: '121212',
    created_at: '2022-06-15 01:40:30.027196000 +0000',
    confirmed_at: '2022-06-14 21:22:04.937699'
    )
  end
  
  after :all do
    @user.destroy
  end
  
  it 'See username and password inputs and Log in button' do
    visit root_path
    expect(has_field?('user_email')).to be true
    expect(has_field?('user_password')).to be true
    expect(has_button?('Log in')).to be true
  end

  it 'Detail error with empty sign in' do
    visit root_path
    within('.container') do
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Detail error with wrong sign in' do
    visit root_path
    within('.container') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Correct Log in redirect to HomePage' do
    visit root_path
    within('.container') do
      fill_in 'user_email', with: 'victorperaltagomez@gmail.com'
      fill_in 'user_password', with: '121212'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page). to have_current_path(root_path)
  end
end
