class Tag < ApplicationRecord
    has_many :user_tags
    has_many :users, through: :user_tags

    has_many :post_tags
    has_many :posts, through: :post_tags

    validates :name, presence: true
    validates :name, uniqueness: true
    #validates :description, presence: true

end
