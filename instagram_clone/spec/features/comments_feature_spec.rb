require 'rails_helper'
require 'helpers/users_helper_spec'
require 'helpers/posts_helper_spec'
require 'helpers/comments_helper_spec'

feature 'reviewing' do
  include User_Helper
  include Post_Helper
  include Comment_Helper


  before do
    sign_up('test@test.com', '12345678')
    create_post
  end
  

  scenario 'allows user to leave a comment' do
    leave_comment
    expect(current_path).to eq '/posts'
    expect(page).to have_content('Cool')
  end

  scenario 'cannot leave a comment if not signed in' do
    click_link 'Sign out'
    visit '/posts'
    click_link 'Leave Comment'
    expect(current_path).to eq '/users/sign_in'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

end