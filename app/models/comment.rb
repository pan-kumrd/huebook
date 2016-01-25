class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    has_many :likes, as: :object

    def self.user_liked()
        joins(:likes).where(likes: { user_id: User.current_user.id }).exists?
    end

    def user_liked()
        likes.where(user_id: User.current_user.id).exists?
    end
end
