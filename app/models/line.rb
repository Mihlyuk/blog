class Line < ApplicationRecord
  belongs_to :poem
  has_and_belongs_to_many :gramms
end
