class Track < ApplicationRecord
  belongs_to :guest
  belongs_to :room
  enum status: ["Entered", "Left"]
end
