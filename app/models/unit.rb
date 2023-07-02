class Unit < ApplicationRecord
  belongs_to :chapter
  delegate :course, to: :chapter

  validates :name, presence: true
  validates :content, presence: true
  validates :chapter_id, presence: true
  validates :order, presence: true, uniqueness: { scope: :chapter_id }
end
