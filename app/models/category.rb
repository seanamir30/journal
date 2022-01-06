class Category < ApplicationRecord
	belongs_to :user
	has_many :tasks, dependent: :destroy


    validates :title, allow_blank: false, presence: true
    validates :description, allow_blank: false, presence: true
end
