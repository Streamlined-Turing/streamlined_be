class Api::V1::Users::MediaController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user_media = user.user_medias.find_by(media_id: params[:id])
    if user_media
      list = List.find_by(user_id: params[:user_id], name: params[:list])
      media_list = user.media_lists.find_by(user_media_id: user_media)
      media_list.update(list: list)
      render status: :no_content
    else
      list = user.lists.find_by(name: params[:list])
      user_media = UserMedia.create!(media_id: params[:id])
      media_list = MediaList.create!(list: list, user_media: user_media)
      render status: :no_content
    end
  end
end



