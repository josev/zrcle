class CommentReply < ActiveRecord::Base
	validates :comment_id, :user_id, :comment, :date, presence: true
	belongs_to :comment
	belongs_to :user
end
