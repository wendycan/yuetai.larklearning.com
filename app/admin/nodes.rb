#!/bin/env ruby
# encoding: utf-8

ActiveAdmin.register Node do
  menu priority: 5, label: '标签'

  controller do
    def permitted_params
      params.permit node: [ :name]
    end
  end
end
