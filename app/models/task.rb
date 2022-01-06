class Task < ApplicationRecord
	belongs_to :category

	
    validates :title, allow_blank: false, presence: true
    validates :description, allow_blank: false, presence: true
    validates :due_date, allow_blank: false, presence: true
end
