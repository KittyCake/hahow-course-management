class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units, dependent: :destroy

  validates :name, presence: true
  validates :course_id, presence: true
  validates :order, presence: true, uniqueness: { scope: :course_id }
end
