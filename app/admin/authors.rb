#!/bin/env ruby
# encoding: utf-8

ActiveAdmin.register Author do
  menu priority: 3, label: '作者'

  controller do
    def permitted_params
      params.permit author: [ :name, :email]
    end
  end
end
