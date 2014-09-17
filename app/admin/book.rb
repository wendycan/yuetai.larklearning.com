#!/bin/env ruby
# encoding: utf-8

ActiveAdmin.register Book do

  menu priority: 3, label: '书籍'

  controller do
    def permitted_params
      params.permit book: [ :name, :desc, :author_name]
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :desc
    column :author_name
    column :created_at
    column :updated_at
    default_actions
  end

end
