# frozen_string_literal: true

ActiveAdmin.register Ability do
  actions :index, :show
  config.sort_order = 'id_asc'
end
