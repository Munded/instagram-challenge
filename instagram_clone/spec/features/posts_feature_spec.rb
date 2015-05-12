require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Submit a Post'
    end
  end

  context 'creating posts' do
    scenario 'prompts user to fill out a form, then displays the new post' do
      visit '/posts'
      click_link 'Submit a Post'
      fill_in 'Name', with: 'Chin'
      fill_in 'Image', with: 'https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg'
      click_button 'Submit Post'
      expect(page).to have_content 'Chin'
      expect(page).to have_xpath("//img[@src='https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg']")
      expect(current_path).to eq '/posts'
    end
  end

  context 'posts have been added' do

    before do
      Post.create(name: 'Chin', image: 'https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg')
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
  end

 context 'viewing restaurants' do

    let!(:chin){Post.create(name:'Chin', image: 'https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg')}

    scenario 'lets a user view a post' do
     visit '/posts'
     click_link 'Chin'
     expect(page).to have_content 'Chin'
     expect(current_path).to eq "/posts/#{chin.id}"
    end
  end

end