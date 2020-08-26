class Post < ApplicationRecord
  validates :content, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags

  def author
    User.find_by(id: self.user_id).name
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create
    end
  end

  #renders all tags separated by commas
  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
