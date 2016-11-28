class SandwichIngredient < ApplicationRecord
	belongs_to :ingredient
	belongs_to :sandwich
end
