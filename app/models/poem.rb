class Poem < ApplicationRecord
  validates :title, uniqueness: true
end
