class Recipe < ApplicationRecord
	belongs_to :user#レシピというのは必ずuser１人に属する為。
	attachment :image

	with_options presence: true do
		validates :title
		validates :body
		validates :image
	end
end
