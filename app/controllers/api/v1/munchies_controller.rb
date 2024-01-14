class Api::V1::MunchiesController < ApplicationController
  def search
    response = YelpFacade.find_food(params)
  end
end