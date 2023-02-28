class Api::V1::Users::MediaController < ApplicationController
  def update
    require 'pry'; binding.pry
    # user = User.find(params[:user_id])
    # user_media = user.user_medias.find_or_create_by(media_id: params[:media_id])
    # list = List.where(user_id: params[:user_id], name: params[:list])
    # media_list = user.media_lists.find_or_create_by(user_media_id: user_media)
    # medialist.update(list: list)
    #
    user = User.find(params[:user_id])
    user_media = user.user_medias.find_by(media_id: params[:id])
    list = List.where(user_id: params[:user_id], name: params[:list])
    media_list = user.media_lists.find_by(user_media_id: user_media)
    media_list.update(list: list)
  end
end
