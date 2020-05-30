class Recipe < ApplicationRecord
	belongs_to :user#レシピというのは必ずuser１人に属する為。
	attachment :image
end
