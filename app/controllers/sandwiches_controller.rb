class SandwichesController < ApplicationController
	def index
	  sandwiches = Sandwich.all
	  render json: sandwiches
	end

	def create
	  sandwich = Sandwich.create(sandwich_params)
	  render json: sandwich
	end

	def show
		sandwich = Sandwich.find_by(id: params[:id])
		unless sandwich
			render json: {error: "sandwich not found"},
			status: 404
			return
		end

		ingredients = sandwich.ingredients.all
		unless ingredients
			render json: { error: "404 - task not found"}, status: 404
			return
		end
		render json: { sandwich: sandwich, ingredients: ingredients }
	end

	def update
	  sandwich = Sandwich.find_by(id: params[:id])
	  unless sandwich
	    render json: {error: "sandwich not found"},
	    status: 404
	    return
	  end
	  sandwich.update(sandwich_params)
	  render json: sandwich
	end

	def destroy
	  sandwich = Sandwich.find_by(id: params[:id])
	  unless sandwich
	    render json: {error: "sandwich not found"},
	    status: 404
	    return
	  end
	  sandwich.destroy
	  render json: sandwich
	end

	def add_ingredient
		sandwich = Sandwich.find_by(id: params[:sandwich_id])
		unless sandwich
			render json: {error: "sandwich not found"},
			status: 404
			return
		end

		ingredient = Ingredient.find_by(id: params[:ingredient_id])	  
		unless sandwich
			render json: {error: "sandwich not found"},
			status: 404
			return
		end

		ingredients = sandwich.ingredients.all

		sandwich.ingredients.push(ingredient)
		render json: { sandwich: sandwich, ingredients: ingredients }
	end


	private

	def sandwich_params
	  params.require(:sandwich)
	    .permit(:name, :bread_type)
	end
end
