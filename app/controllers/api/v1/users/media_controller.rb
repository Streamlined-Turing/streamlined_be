class Api::V1::Users::MediaController < ApplicationController
  def update
    # TODO: Error handling
    user = User.find(params[:user_id])
    user_media = user.user_medias.find_by(media_id: params[:id])
    list = List.where(user_id: params[:user_id], name: params[:list]).first
    media_list = user.media_lists.find_by(user_media_id: user_media)
    media_list.update(list: list)
    render status: :no_content
  end
end
