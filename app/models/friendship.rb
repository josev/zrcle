class Friendship < ActiveRecord::Base
	validates :user_id, :friend_id, :status, presence: true
	belongs_to :user
	belongs_to :user, :foreign_key => "friend_id"
	alias_attribute :friend, :user
end
