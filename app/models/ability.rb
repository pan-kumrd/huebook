class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [ :destroy ], Comment, :user_id == user.id
      can [ :destroy ], Event, :organizer_id == user.id
      can [ :update, :destroy, :reject, :accept ], Friendship do |f|
        f.friend_id == user.id || f.initiator_id == user.id
      end
      can [ :pending ], Friendship
      can [ :destroy, :show ], Message do |m|
        print(m.sender_id, m.to_id, user.id)
        m.sender_id == user.id || m.to_id == user.id
      end
      can [ :index, :create, :ack ], Message
      can [ :destroy ], Like, :user_id == user.id
      can [ :destroy ], Post, :user_id == user.id
      can [ :update, :destroy ], EventRsvp, :user_id == user.id
      can [ :update, :destroy ], User, :id == user.id
      can [ :read, :create, :like, :unlike, :ack, :invite, :conversations, :filter ],
          [ Comment, Event, EventRsvp, Friendship, Like, Post, User, Wall ]

      can [ :search ], Search
      can [ :default, :show ], Wall

      # Enables /app
      can [ :read ], Huebook
    else
      can :create, User
    end
  end
end
