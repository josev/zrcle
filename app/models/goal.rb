class Goal < ActiveRecord::Base
    validates :name, :description, :goal_category_id, :expected_result, :date, :goal_type_id, presence: true
    belongs_to :goal_category
    belongs_to :goal_type
    has_many :users, through: :user_goals
    has_many :user_goals
    mount_uploader :image, ImageUploader
    #after_create :create_usergoal

    #private
    #   def create_usergoal
    #       ug = UserGoal.create(user_id: self.user_id, goal_id: self.id, state: "0")
    #   end

  def default_serializer_options
    { user_id: user_id }.merge(super)
  end

  def self.get_goals(_params)
    if _params[:goal_type_id].present?
      Goal.where(goal_type_id: _params[:goal_type_id])
    elsif _params[:goal_category_id].present?
      Goal.where(goal_category_id: _params[:goal_category_id])
    elsif _params[:user_id].present?
      user_goals = UserGoal.select("goal_id AS id").where(user_id: _params[:user_id], state: "1").order(:state)
      if user_goals.present?
        Goal.where(id: user_goals)
      end
    else
      Goal.all
    end
  end

  def self.search_by_name(text)
    Goal.where("name like '%#{text}%'")
  end
  def self.search_by_category(text)
    Goal.joins("left join goal_categories on goals.goal_category_id=goal_categories.id").where("goal_categories.name like '%#{text}%'")
  end

  def steps
    GoalStep.where(goal_id: self.id)
  end

  def step_completes(user_id)
    UserStep.where(user_id: user_id, goal_step_id: steps, status: 3)
  end

  def current_step(user_id)
    UserStep.where(user_id: user_id, goal_step_id: steps, status: 2).first
  end

  def get_users_by_goal(user)
    User.where(id: self.users.where(user_goals:{private: false})).where.not(id: user.friends).where.not(id: user.id)
  end

  def motivationals
    Comment.where(goal_id: self.id).where.not(to_user_id: nil).order(created_at: :desc)
  end

  def motivationals_by_user(user_id)
    Comment.where(goal_id: self.id, to_user_id: user_id).order(created_at: :desc)
  end
end
