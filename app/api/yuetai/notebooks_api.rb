require 'mail'

module Yuetai
  class Notebooks < Grape::API
    resource :notebooks do
      desc 'Get all notebooks'

      get do
        if params[:user_id]
          user = User.find(params[:user_id])
          notebooks = user.notebooks.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
        else
          notebooks = Notebook.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
        end
        present :notebooks, notebooks, with: Entities::Notebook
        present :per_page, notebooks.per_page
        present :page, notebooks.current_page
        present :total_pages, notebooks.total_pages
        present :total_entries, notebooks.total_entries
      end

      put :import do
        Mail.defaults do
          retriever_method :pop3, :address    => "pop.exmail.qq.com",
                                  :port       => 995,
                                  :user_name  => 'test@larklearning.com',
                                  :password   => '111111Lark',
                                  :enable_ssl => true
        end
        email = Mail.last
        {status: 200, email: email.attachments.last.body.to_s.force_encoding('utf-8')}
      end

      route_param :id, requirements: /[^\/]+/ do
        delete do
          authenticate!
          notebook = Notebook.find(params[:id])
          notebook.destroy!
          {status: 204}
        end
      end
    end
  end
end
