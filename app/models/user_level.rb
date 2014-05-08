class UserLevel < ActiveRecord::Base
  validates :user_id, :level_id, presence: true
  belongs_to :user
  belongs_to :level
  after_create :first_points

  def self.get_user_levels(_params)
    if params[:user_level_id].present?
      UserLevel.find_by_id(_params[:user_level_id])
    elsif _params[:user_id].present?
      UserLevel.where(user_id: _params[:user_id])
    elsif _params[:level_id].present?
      UserLevel.where(level_id: _params[:level_id])
    else
      UserLevel.all
    end
  end

  def add_points(_points)
    points = self.points.present? ? self.points : 0
    points += _points
    if points<self.level.required_points
      self.points = points
    else
      points = points - self.level.required_points
      level = Level.where(level_number: (self.level.level_number+1)).first
      self.level = level if level.present?
      self.points = points 
    end
    self.save
  end

  protected
    def first_points
      self.add_points(100)
    end
end
