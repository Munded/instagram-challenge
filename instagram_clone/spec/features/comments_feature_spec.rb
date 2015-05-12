require 'rails_helper'

feature 'reviewing' do
  before {Post.create name: 'Chin'}

  scenario 'allows user to leave a comment' do
    visit '/posts'
    click_link 'Leave Comment'
    fill_in 'Message', with: 'Cool'
    click_button 'Leave Comment'

    expect(current_path).to eq '/posts'
    expect(page).to have_content('Cool')
  end
end