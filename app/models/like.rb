class Like < ActiveRecord::Base
    belongs_to :object, polymorphic: true
end
