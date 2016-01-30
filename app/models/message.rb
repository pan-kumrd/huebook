class Message < ActiveRecord::Base
    belongs_to :sender, class_name: 'User'
    belongs_to :to, class_name: 'User'
end
