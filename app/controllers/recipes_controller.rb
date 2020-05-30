class RecipesController < ApplicationController
  def index
  end

  def show
  	@recipe = Recipe.find(params[:id])
  end

  def new
  	@recipe = Recipe.new #recipeモデルから空のモデルをもってくる。new.html.erbに渡される。
  end

  def create
  	@recipe = Recipe.new(recipe_params)
  	@recipe.user_id = current_user.id #誰が投稿したのか。投稿するのはログインしているcurrent_userである為、user.idのところのカラムに今ログインしている人のid,つまり誰が投稿したのが保持される。
  	@recipe.save #今、投稿された内容というものを.saveでデータベースに保存される
  	redirect_to recipe_path(@recipe) #レシピの詳細画面に遷移します。(どのレシピ遷移するのかを指定する必要がある為、@recipeとすると今投稿された詳細画面に遷移する)
  end

  def edit
  end


  private
  def recipe_params #recipe_params
  	params.require(:recipe).permit(:title, :body, :image)
  end

end
