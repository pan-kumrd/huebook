class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :orig_post, class_name: "Post", foreign_key: "orig_post_id", primary_key: "id"
    belongs_to :wall, polymorphic: true
    has_many :shares, class_name: "Post", foreign_key: "orig_post_id", primary_key: "id"
    has_many :comments
    has_many :likes, as: :object

    def self.user_liked()
        joins(:likes).where(likes: { user_id: User.current_user.id }).exists?
    end

    def user_liked()
        likes.where(user_id: User.current_user.id).exists?
    end
end
