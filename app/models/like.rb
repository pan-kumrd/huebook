class Like < ActiveRecord::Base
    resourcify
    belongs_to :user
    belongs_to :object, polymorphic: true
end
