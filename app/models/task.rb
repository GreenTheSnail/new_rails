  class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :tag_associations, dependent: :destroy
  has_many :tags, through: :tag_associations
  accepts_nested_attributes_for :tag_associations, allow_destroy: true
  # accepts_nested_attributes_for :tags
  validates :title,  presence: true
  validates :note,  presence: true
  def self.search(query)
    # Title is for the above case, the OP incorrectly had 'name'
    where("title LIKE ?", "%#{query}%")
  end

end
