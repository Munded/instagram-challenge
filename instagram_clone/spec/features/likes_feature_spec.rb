require 'rails_helper'
require 'helpers/users_helper_spec'
require 'helpers/posts_helper_spec'
require 'helpers/comments_helper_spec'

feature 'likes' do
  include User_Helper
  include Post_Helper
  include Comment_Helper

  before do
    sign_up('test@test.com', '12345678')
    create_post
    leave_comment
  end

  scenario 'can view likes' do
    visit '/posts'
    expect(page).to have_content '0 likes'
  end

  context 'can like a post' do

    scenario 'can like a post if signed in' do
      visit '/posts'
      click_link 'Like Chin'
      click_button 'Yes'
      expect(page).to have_content '1 likes'
    end

    scenario 'cannot like a post if not signed in' do
      click_link 'Sign out'
      visit '/posts'
      click_link 'Like Chin'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

    scenario 'can only like a post once' do
      visit '/posts'
      click_link 'Like Chin'
      click_button 'Yes'
      click_link 'Like Chin'
      click_button 'Yes'
      expect(page).to have_content 'have already liked this post'
    end

    scenario 'can unlike a post if liked the post' do
      visit '/posts'
      click_link 'Like Chin'
      click_button 'Yes'
      expect(page).to have_content 'Unlike'
      click_link 'Unlike'
      expect(page).to have_content '0 likes'
      expect(page).to have_content 'Post has been unliked'
    end
  end
  
end