class Gramm < ApplicationRecord
  has_and_belongs_to_many :lines
  validates :id, uniqueness: true
end
