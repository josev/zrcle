class Profile < ActiveRecord::Base
  validates :user_id, :date, presence: true
  belongs_to :user

  def self.get_profiles(_params)
    if _params[:profile_id].present?
      Profile.find_by_id(_params[:profile_id])
    elsif _params[:user_id].present?
      Profile.where(user_id: _params[:user_id])
    else
      Profile.all
    end
  end
end
