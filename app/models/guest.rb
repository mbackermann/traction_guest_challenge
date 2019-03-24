class Guest < ApplicationRecord
  has_many :tracks, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :document_id, presence: true
end
