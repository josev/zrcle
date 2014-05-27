class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :goal_category_id, :expected_result, :goal_type_id, 
  :state,:users, :friends, :progress, :current_step, :steps, :image, :private

  #has_many :users, through: :user_goals

  def users
  	object.users.count
  end

  def steps
    GoalStep.where(goal_id: object.id).count
  end

  def include_friends?
    friends
  end
  def friends
    u = User.find_by_id(options[:user_id])
    if u.present?
      UserGoal.where(goal_id: object.id, user_id: u.friends).count
    else
      nil
    end
  end

  def include_progress?
    progress
  end
  def progress
    u = User.find_by_id(options[:user_id])
    if u.present?
      object.step_completes(u.id).count
    else
      nil
    end
  end

  def include_current_step?
    current_step
  end
  def current_step
    u = User.find_by_id(options[:user_id])
    if u.present?
      object.current_step(u.id).present? ? object.current_step(u.id).goal_step.order : "nothing"
    else
      nil
    end
  end

  def include_state?
    state
  end
  def state
    u = User.find_by_id(options[:user_id])
    if u.present?
      g = u.goals.where(goal_id: object.id).first
      if g.present?
        g.state
      else
        "unknown"
      end
    else
      nil
    end
  end

  def include_private?
    private
  end
  def private
    u = User.find_by_id(options[:user_id])
    if u.present?
      g = u.goals.where(goal_id: object.id).first
      if g.present?
        g.private
      else
        "unknown"
      end
    end
  end

  def image
    if object.image_url.present?
      "http://zircle.herokuapp.com#{object.image_url.to_s}"
    end
  end
end
