class Api::V1::MunchiesController < ApplicationController
  def search
    if params[:destination].blank? || params[:food].blank?
      render json: { status: 400, error: "Must have a Desition or Food category"}, status: :bad_request
    else
      response = YelpFacade.find_food(params)
      render json: response, status: :created
    end
  end
end