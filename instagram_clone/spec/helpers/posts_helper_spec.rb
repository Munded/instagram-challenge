require 'rails_helper'

module Post_Helper

  def create_post
    visit '/posts'
    click_link 'Submit a Post'
    fill_in 'Name', with: 'Chin'
    fill_in 'Image', with: 'https://lh3.googleusercontent.com/-0wOhLe6FaEc/AAAAAAAAAAI/AAAAAAAAACU/dscpJHyiBNM/photo.jpg'
    click_button 'Submit Post'
  end
  
end