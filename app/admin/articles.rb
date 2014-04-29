ActiveAdmin.register Article do
  controller do
    def permitted_params
      params.permit article: [ :name, :body, :author, :node_id, :author_id, :music_script]
    end
  end
end
