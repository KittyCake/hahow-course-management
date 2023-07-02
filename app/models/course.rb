class Course < ApplicationRecord
  has_many :chapters, dependent: :destroy
  belongs_to :instructor

  validates :name, presence: true
end
