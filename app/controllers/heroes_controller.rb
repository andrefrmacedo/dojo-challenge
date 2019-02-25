# frozen_string_literal: true

class HeroesController < ApiController
  def index
    render json: Hero.all, status: :ok
  end

  def show
    hero = Hero.find_by(id: params[:id])
    if hero
      render json: hero, status: :ok
    else
      render json: not_found_error, status: :not_found
    end
  end
end
