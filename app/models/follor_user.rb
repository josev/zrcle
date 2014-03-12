class FollorUser < ActiveRecord::Base
	validates :user_id, :follow_user_id, presence: true
	belongs_to :user
	belongs_to :user, :foreign_key => "follow_user_id"
	alias_attribute :follow_user, :user
end
