# frozen_string_literal: true

class ApplicationController < ActionController::API
  def not_found_error
    {
      error: {
        status: 404,
        title: I18n.t('errors.not_found.title'),
        detail: I18n.t('errors.not_found.detail')
      }
    }
  end
end
