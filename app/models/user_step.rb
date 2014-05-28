class UserStep < ActiveRecord::Base
  validates :user_id, :goal_step_id, :status, presence: :true
  belongs_to :goal_step
  belongs_to :user

  def self.get_user_steps(_params)
    if _params[:goal_id].present?
      UserStep.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      UserStep.where(user_id: _params[:user_id])
    elsif _params[:user_step_id].present?
      UserStep.find_by_id(_params[:user_step_id])
    else
      UserStep.all
    end
  end

  def self.current_step(_params)
    g = Goal.find_by_id(_params[:goal_id])
    g.current_step(_params[:user_id])
  end

  def self.step_complete(_params)
    user = User.find_by_id(_params[:user_id])
    current = UserStep.current_step(_params)
    if current.present?
      current.status = 3
      if !current.save
        return current
      end
      goal_step_next = GoalStep.where(goal_id: current.goal_step.goal_id, order: current.goal_step.order+1).first
      if goal_step_next.present?
        step_next = UserStep.where(user_id: current.user_id, goal_step_id: goal_step_next.id).first
        if step_next.present?
          step_next.status = 2
          if step_next.save
            user.user_level.add_points(10)
            step_next
          end
        end
      else
        if current.goal_step.goal.steps.count == current.goal_step.goal.step_completes(_params[:user_id]).count
          user_goal = UserGoal.where(user_id: current.user_id, goal_id: current.goal_step.goal_id).first
          user_goal.state = 2
          if user_goal.save
            user.user_level.add_points(100)
            post = Post.new
            post.user_step_id = UserStep.where(user_id: current.user_id, goal_step_id: current.id)
            post.title = 'Complete Goal'
            post.comment = 'Congratualtions'
            post.save
            nil
          else
            user_goal
          end
        end
      end
    end
  end
end
