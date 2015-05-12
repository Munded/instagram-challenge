require 'rails_helper'
require 'helpers/posts_helper_spec'
require 'helpers/users_helper_spec'

feature 'posts' do

  include Post_Helper
  include User_Helper

  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Submit a Post'
    end
  end

  context 'creating posts' do
    scenario 'prompts user to fill out a form, then displays the new post' do
      sign_up('test@test.com', '12345678')
      create_post
      expect(page).to have_content 'Chin'
      expect(page).to have_xpath("//img[@src='https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg']")
      expect(current_path).to eq '/posts'
    end

    scenario 'cannot create post if not logged in' do
      visit '/posts'
      click_link 'Submit a Post'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end

  context 'posts have been added' do

    before do
      sign_up('test@test.com', '12345678')
      create_post
    end

    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content('Chin')
      expect(page).to have_xpath("//img[@src='https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg']")
      expect(page).not_to have_content('No Posts yet')
    end

    scenario 'let a user edit a post' do
     visit '/posts'
     click_link 'Edit Chin'
     fill_in 'Name', with: 'Chinzzz'
     click_button 'Update Post'
     expect(page).to have_content 'Chinzzz'
     expect(current_path).to eq '/posts'
    end

    scenario 'removes a post when a user clicks a delete link' do
      visit '/posts'
      click_link 'Delete Chin'
      expect(page).not_to have_content 'Chin'
      expect(page).to have_content 'Post deleted successfully'
    end
  end

 context 'viewing restaurants' do

    before do
      sign_up('test@test.com', '12345678')
    end

    let!(:chin){Post.create(name:'Chin', image: 'https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg')}

    scenario 'lets a user view a post' do
     visit '/posts'
     click_link 'Chin'
     expect(page).to have_content 'Chin'
     expect(current_path).to eq "/posts/#{chin.id}"
    end
  end

end