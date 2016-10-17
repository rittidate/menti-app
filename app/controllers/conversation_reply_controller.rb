class ConversationReplyController < ApplicationController
  def upload
    msg = ConversationReply.create(conversation_image_params) do |f|
      f.user = current_user
      f.seen = false
    end
    redirect_to request.referer
  end

private
  def conversation_image_params
    params.require(:conversation_reply).permit(:conversation_id, :image)
  end
end
