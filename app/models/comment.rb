class Comment < ActiveRecord::Base
	validates :goal_id, :user_id, :comment, :date, presence: true
	belongs_to :goal
	belongs_to :user
end
