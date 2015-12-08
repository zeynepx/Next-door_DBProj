class Reply < ActiveRecord::Base
  belongs_to :micropost, dependent: :destroy
  belongs_to :user, dependent: :destroy
  default_scope -> { order(:created_at) }
end
