class Post < ActiveRecord::Base
  validates :user_step_id, :title, :comment, presence: true
  belongs_to :user_step
  has_one :user, through: :user_step
  has_one :goal, through: :user_step
  has_one :goal_step, through: :user_step


  def self.get_posts(_params)
    if _params[:goal_id].present?
      Post.joins(user_step: :goal_step).where(goal_steps: {goal_id: _params[:goal_id]})
    elsif _params[:user_id].present?
      Post.joins(:user_step).where(user_steps: {user_id: _params[:user_id]})
    elsif _params[:post_id].present?
      Post.find_by_id(_params[:post_id])
    else
      Post.all
    end
  end

  def self.get_timeline(user, goal)
    motivationals = Comment.get_motivational_sent(user).where(goal_id: goal.id)
    motivationals += Comment.get_motivational_received(user).where(goal_id: goal.id)

    posts = Post.joins(:user_step => :goal_step).where(user_steps: {user_id: user.id}, goal_steps: {goal_id: goal.id})

    tmlns = Array.new
    motivationals.each do |m|
      t = Timeline.new(m.updated_at, m.user_id, m.goal_id, "Motivational", m.to_user_id)
      tmlns.push(t)
    end
    posts.each do |p|
      t = Timeline.new(p.created_at, p.user.id, p.goal.id, "Post", nil)
      tmlns.push(t)
    end
    tmlns.sort_by{|t| -t[:date]}
  end

  def self.get_timeline_goal(goal)
    motivationals = Comment.all.where(goal_id: goal.id).where.not(to_user_id: nil)
    motivationals += Comment.all.where(goal_id: goal.id).where.not(to_user_id: nil)

    posts = Post.joins(:user_step => :goal_step).where(goal_steps: {goal_id: goal.id})

    tmlns = Array.new
    motivationals.each do |m|
      t = Timeline.new(m.updated_at, m.user_id, m.goal_id, "Motivational", m.to_user_id)
      tmlns.push(t)
    end
    posts.each do |p|
      t = Timeline.new(p.created_at, p.user.id, p.goal.id, "Post", nil)
      tmlns.push(t)
    end
    tmlns.sort_by{|t| -t[:date]}
  end
end

class Timeline
  @@no_of_timelines = 0
  def initialize(date, user_id, goal_id, title, comment, to_user_id)
    @goal_id = goal_id
    @user_id = user_id
    @date = date
    @title = title
    @comment = comment
    @to_user_id = to_user_id
  end
end