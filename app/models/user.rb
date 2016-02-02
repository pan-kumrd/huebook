class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :posts, as: :wall
  has_many :organizer_events, class_name: 'EventRsvp', foreign_key: 'organizer_id'
  has_many :events, through: :event_rsvps
  has_many :friendships

  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def friends
    return User.where("id IN (SELECT CASE WHEN initiator_id = ? THEN friend_id ELSE initiator_id END 
                              FROM Friendships
                              WHERE (initiator_id = ? OR friend_id = ?) AND status = 1)",
                      id, id, id)
  end

  def friends?(user)
    return Friendship.where("((initiator_id = ? AND friend_id = ?) OR (initiator_id = ? AND friend_id = ?)) AND status = 1",
                            user.id, id, id, user.id)
                     .count == 1
  end
end
