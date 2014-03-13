class Goal < ActiveRecord::Base
  validates :user_id, :name, :description, :goal_category_id, :expected_result, :date, :goal_type_id, presence: true
  belongs_to :user
  belongs_to :goal_category
  belongs_to :goal_type

  after_create :create_usergoal

  private
    def create_usergoal
      ug = UserGoal.create(user_id: self.user_id, goal_id: self.id, state: "0")
    end
end
