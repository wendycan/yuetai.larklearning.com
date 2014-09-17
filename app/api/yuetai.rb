Dir["#{Rails.root}/app/api/*.rb"].each { |file| require file }

module Yuetai
  class Api < Grape::API
    #api
    version 'v1', using: :path
    format :json
    default_format :json
    desc 'Return version info'
    get do
      {version: '1'}
    end

    mount Books
    mount Articles

  end
end
