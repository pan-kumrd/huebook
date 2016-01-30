class EventRsvp < ActiveRecord::Base
    enum status: [ :invited,
                   :accepted,
                   :tentative,
                   :rejected ]

    belongs_to :invited_by, class_name: 'User'
    belongs_to :event
    belongs_to :user
end
