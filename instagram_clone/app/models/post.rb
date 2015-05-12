class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  has_many :likes, 
  -> { extending WithUserAssociationExtension },
      dependent: :restrict_with_exception,
      dependent: :destroy
  belongs_to :user


end
