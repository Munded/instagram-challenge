class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :user

  def was_posted(current_user)
    self.user == current_user
  end
  
end
