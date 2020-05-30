class RecipesController < ApplicationController
  def index
  	@recipes = Recipe.all #レシピの一覧画面なので、@recipes(複数形)となり、で登録されている全ての情報を取ってくる為、モデル名.all(Recipe.all)となる。これでデータベースに登録されているレシピの情報が全て配列で@recipesに渡せる。
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
  	@recipe = Recipe.find(params[:id]) #これから編集したいレシピを１つだけ持ってくる。つまり、編集したいレシピの情婦を１つというのを@recipeという変数に入れました。
  end

  def update
  	@recipe = Recipe.find(params[:id])
  	@recipe.update(recipe_params)
  	redirect_to recipe_path(@recipe)
  end


  private
  def recipe_params #recipe_params
  	params.require(:recipe).permit(:title, :body, :image)
  end

end
