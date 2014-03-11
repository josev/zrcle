class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :user, :foreign_key => "friend_id"
	alias_attribute :friend, :user
end
