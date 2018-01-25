module Api::V1
	class ApiController < ApplicationController

		def index
			render json: model.page(params[:page]), status: :ok
		end

		def show
			render json: find_model, status: :ok
		end

		def create
			render json: model.create!(filtered_params), status: :created
		end

		def update
			obj = find_model
			obj.update_attributes!(filtered_params)
			render json: obj, status: :ok
		end

		def destroy
			render json: find_model.destroy!, status: :no_content
		end

		def find_model
			model.find(params[:id])
		end
	end
end