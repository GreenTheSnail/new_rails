class Category < ApplicationRecord
  belongs_to :user
    has_many :tasks, dependent: :nullify 
    validates :title, presence: true
    validates :color, presence: true
end
