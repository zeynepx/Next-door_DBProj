class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy

  has_many :active_relationships,  class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :friendships
  has_many :user2s, through: :friendships

  # has_many :active_friendships, class_name: "Friendship",
  #           foreign_key: "user1_id",
  #           dependent:   :destroy
  # has_many :passive_relationships, class_name:  "Relationship",
  #          foreign_key: "user2_id",
  #          dependent:   :destroy

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                 BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # Change here, so we can make neighbor feed and friends feed, block and neighborhood feed.
  # BTW, how can we make sure that folling_ids is calling DB?

  def neighbor_feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def friend_feed
    friend_ids_1 = " (select user2_id  from friendships where user1_id = :user_id and status = 'friend')"
                    # union
    friend_ids_2 = "(select user1_id from friendships where user2_id = :user_id and status = 'friend')"

    Micropost.where("user_id IN (#{friend_ids_1}) OR id IN (#{friend_ids_2})", user_id: id)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end
