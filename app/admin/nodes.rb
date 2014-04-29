ActiveAdmin.register Node do
  controller do
    def permitted_params
      params.permit node: [ :name]
    end
  end
end
