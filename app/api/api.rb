Dir["#{Rails.root}/app/api/yuetai/*.rb"].each { |file| require file }

class Api < Grape::API
  #api
  version 'v1', using: :path
  format :json
  default_format :json
  desc 'Return version info'
  get do
    {version: '1'}
  end

  mount Yuetai::Blogs
  mount Yuetai::Series
  mount Yuetai::Presentations

end
