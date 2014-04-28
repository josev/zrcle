class Level < ActiveRecord::Base
  validates :level_number, :required_points, presence: true

  def self.get_levels(_params)
    if _params[:level_id].present?
      Level.find_by_id(_params[:level_id])
    else
      Level.all
    end
  end
end
