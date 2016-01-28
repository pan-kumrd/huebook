class Friendship < ActiveRecord::Base
    enum statuses: [ :requested,
                     :accepted ]

    belongs_to :initiator, class_name: 'User',
                           foreign_key: 'id'
    belongs_to :friend, class_name: 'User',
                        foreign_key: 'id'

end
