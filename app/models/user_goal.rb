class UserGoal < ActiveRecord::Base
  validates :user_id, :goal_id, :status, validates: true
  belongs_to :user
  belongs_to :goal
end
