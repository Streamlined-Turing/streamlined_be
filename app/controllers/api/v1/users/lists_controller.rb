      list = MediaFacade.user_list_details(params[:user_id], params[:list])  
      render json: MediaSerializer.new(list), status: :ok
