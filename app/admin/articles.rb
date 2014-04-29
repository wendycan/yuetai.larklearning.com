#!/bin/env ruby
# encoding: utf-8
ActiveAdmin.register Article do

  menu priority: 2, label: '文章'

  controller do
    def permitted_params
      params.permit article: [ :name, :body, :node_id, :author_id, :music_script]
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :author
    column :utag
    column :created_at
    column :updated_at
    default_actions
  end
end
