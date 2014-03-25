class UserLevel < ActiveRecord::Base
	validates :user_id, :level_id, presence: true
	belongs_to :user
	belongs_to :level
end
