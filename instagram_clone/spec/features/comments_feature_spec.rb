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

  context 'already created comment' do
    before do
      leave_comment
    end

    scenario 'can edit comment if created' do
      visit '/posts'
      click_link 'Edit Comment'
      fill_in 'Message', with: 'ew'
      click_button 'Update Comment'
      expect(page).to have_content 'ew'
    end

    scenario 'cannot edit comment if not signed it' do
      click_link 'Sign out'
      visit '/posts'
      click_link 'Edit Comment'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

    scenario 'cannot edit comment if did not create' do
      click_link 'Sign out'
      sign_up('test2@test.com', '12345678')
      visit '/posts'
      click_link 'Edit Comment'
      fill_in 'Message', with: 'ew'
      click_button 'Update Comment'
      expect(page).to have_content 'Cannot edit comment'
    end


    scenario 'can delete comment if created' do
      visit '/posts'
      click_link 'Delete Comment'
      expect(page).not_to have_content 'Cool'
    end

    scenario 'cannot delete comment if not signed it' do
      click_link 'Sign out'
      visit '/posts'
      click_link 'Delete Comment'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

    scenario 'cannot delete comment if did not create' do
      click_link 'Sign out'
      sign_up('test2@test.com', '12345678')
      click_link 'Delete Comment'
      expect(page).to have_content 'Cool'
      expect(page).to have_content 'Cannot delete comment'
    end
  end
end