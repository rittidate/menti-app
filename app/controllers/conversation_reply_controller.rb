class ConversationReplyController < ApplicationController
  def upload
    msg = ConversationReply.create(conversation_image_params) do |f|
      f.user = current_user
      f.seen = false
    end
    redirect_to request.referer
  end

  def delete
    history = ConversationHistory.where(user: current_user, conversation_id: params[:conversation_id]).first_or_create!
    history.conversation_replies_id = params[:lasted_reply]
    history.save!
    render json: { status: 200, data: history }
  end

private
  def conversation_image_params
    params.require(:conversation_reply).permit(:conversation_id, :image)
  end
end
