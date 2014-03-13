class GoalMessage < ActiveRecord::Base
  validates :from_user_id, :to_goal_id, :message, :date, presence: true
  belongs_to :user, :foreign_key => "from_user_id"
  alias_attribute :from_user, :user
  belongs_to :goal, :foreign_key => "to_goal_id"
  alias_attribute :to_goal, :goal
end
