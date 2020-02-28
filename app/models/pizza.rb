class Pizza < ApplicationRecord

  belongs_to :user
  belongs_to :size
  belongs_to :specialty

  validates :name, presence: true, allow_blank: false

end
