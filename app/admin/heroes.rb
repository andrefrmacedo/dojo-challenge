# frozen_string_literal: true

ActiveAdmin.register Hero do
  actions :index, :show
  config.sort_order = 'id_asc'
end
