# frozen_string_literal: true

class AbilitiesController < ApplicationController
  def index
    if params[:hero_id]
      hero_abilities
    else
      render json: Ability.all, status: :ok
    end
  end

  def show
    ability = Ability.find_by(id: params[:id])
    if ability
      render json: ability, status: :ok
    else
      render json: not_found_error, status: :not_found
    end
  end

  private

    def hero_abilities
      hero = Hero.find_by(id: params[:hero_id])
      if hero
        render json: hero, include: :abilities, status: :ok
      else
        render json: not_found_error, status: :not_found
      end
    end
end