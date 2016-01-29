class MessagesController < AppController
    before_action :set_post, only: [:show, :like, :unlike, :likes, :shares, :destroy]
    layout false

end
 
