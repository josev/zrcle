class Goal < ActiveRecord::Base
    validates :name, :description, :goal_category_id, :expected_result, :date, :goal_type_id, presence: true
    has_many :user
    belongs_to :goal_category
    belongs_to :goal_type

    #after_create :create_usergoal

    #private
    #   def create_usergoal
    #       ug = UserGoal.create(user_id: self.user_id, goal_id: self.id, state: "0")
    #   end

  def self.get_goals(_params)
    if _params[:goal_type_id].present?
      goals = Goal.where(goal_type_id: _params[:goal_type_id])
    elsif _params[:goal_category_id].present?
      goals = Goal.where(goal_category_id: _params[:goal_category_id])
    elsif params[:user_id].present?
      user_goals = UserGoal.select("goal_id AS id").where(user_id: _params[:user_id])
      if user_goals.present?
        goals = Goal.where(id: user_goals)
      end
    else
      @goals = Goal.all
    end
  end
end
