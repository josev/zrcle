class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :goal_category_id, :expected_result, :goal_type_id, 
  :users, :friends

  #has_many :users, through: :user_goals

  def users
  	object.users.count
  end

  def friends
    u = User.find_by_id(options[:user_id])
    if u.present?
      u.friends
      UserGoal.where(goal_id: object.id, user_id: u.friends).count
    else
      0
    end
  end

end
