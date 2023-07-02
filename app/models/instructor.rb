class Instructor < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates :name, presence: true
end
