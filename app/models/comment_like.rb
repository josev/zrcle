class CommentLike < ActiveRecord::Base
  validates :comment_id, :user_id, presence: true
  belongs_to :comment 
  belongs_to :user
end
