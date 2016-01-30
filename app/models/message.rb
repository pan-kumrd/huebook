class Message < ActiveRecord::Base
    resourcify
    belongs_to :sender, class_name: 'User'
    belongs_to :to, class_name: 'User'
end
