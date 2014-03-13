class UserGoal < ActiveRecord::Base
  validates :user_id, :goal_id, :state, presence: true
  belongs_to :user
  belongs_to :goal
end
