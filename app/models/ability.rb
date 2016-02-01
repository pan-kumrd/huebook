class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [ :destroy ], Comment, :user_id == user.id
      can [ :destroy ], Event, :organizer_id == user.id
      can [ :update, :destroy ], Friendship do |f|
        f.friend_id == user.id || f.initiator_id == user.id
      end
      can [ :destroy ], Message do |m|
        f.sender_id == user.id || f.to_id == user.id
      end
      can [ :destroy ], Like, :user_id == user.id
      can [ :destroy ], Post, :user_id == user.id
      can [ :update, :destroy ], EventRsvp, :user_id == user.id
      can [ :update, :destroy ], User, :id == user.id
      can :read, :all
    end
  end
end
