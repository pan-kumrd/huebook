class MessagesController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :set_post, only: [:show, :like, :unlike, :likes, :shares, :destroy]
    layout false

end
 
