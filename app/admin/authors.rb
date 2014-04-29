ActiveAdmin.register Author do
  controller do
    def permitted_params
      params.permit author: [ :name, :email]
    end
  end
end
