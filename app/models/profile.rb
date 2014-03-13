class Profile < ActiveRecord::Base
  validates :user_id, :date, presence: true
end
