class FollorUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :user, :foreing_key => "follow_user_id"
	alias_attribute :follow_user, :user
end
