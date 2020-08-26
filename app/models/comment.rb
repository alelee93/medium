class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :post

  def author
    User.find_by(id: self.user_id)
  end

end
