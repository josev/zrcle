class UserMessage < ActiveRecord::Base
  validates :from_user_id, :to_user_id, :message, :date, presence: true
  belongs_to :user, :foreign_key => "from_user_id"
  alias_attribute :from_user, :user
  belongs_to :user, :foreign_key => "to_user_id"
  alias_attribute :to_user, :user
end
