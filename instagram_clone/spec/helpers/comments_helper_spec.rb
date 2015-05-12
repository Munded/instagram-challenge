require 'rails_helper'

module Comment_Helper

  def leave_comment
    visit '/posts'
    click_link 'Leave Comment'
    fill_in 'Message', with: 'Cool'
    click_button 'Leave Comment'
  end
end
