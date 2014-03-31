class UserConfiguration < ActiveRecord::Base
  belongs_to :user

  def self.get_user_configurations(_params)
    if _params[:user_configuration_id].present?
      user_configurations = UserConfiguration.find_by_id(_params[:user_configuration_id])
    elsif _params[:user_id].present?
      user_configurations = UserConfiguration.where(user_id: _params[:user_id])
    else
      user_configurations = UserConfiguration.all
    end
  end
end
