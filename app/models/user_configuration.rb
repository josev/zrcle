class UserConfiguration < ActiveRecord::Base
  belongs_to :user

  def self.get_user_configurations(_params)
    if _params[:user_configuration_id].present?
      UserConfiguration.find_by_id(_params[:user_configuration_id])
    elsif _params[:user_id].present?
      UserConfiguration.where(user_id: _params[:user_id])
    else
      UserConfiguration.all
    end
  end
end
