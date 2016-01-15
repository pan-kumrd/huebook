class EventRsvp < ActiveRecord::Base
    enum status: [ :invited,
                   :accepted,
                   :tentative,
                   :rejected ]

    belongs_to :user
    belongs_to :event
end
