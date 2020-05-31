class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  # ログインしていない人のアクセス制限です。ログインしていない人はこの全てのアクションにアクセスができなくなるが、今回はindexアクションに関してはアクセスを許可したいのでexcept: [:index]とする。

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
  	if @recipe.save #今、投稿された内容というものを.saveでデータベースに保存される
  		redirect_to recipe_path(@recipe), notice: '投稿に成功しました'#レシピの詳細画面に遷移します。(どのレシピ遷移するのかを指定する必要がある為、@recipeとすると今投稿された詳細画面に遷移する)
  	else
  		render :new
  	end
  end

  def edit
  	@recipe = Recipe.find(params[:id]) #これから編集したいレシピを１つだけ持ってくる。つまり、編集したいレシピの情婦を１つというのを@recipeという変数に入れました。
  	if @recipe.user != current_user #もしレシピに紐づいているユーザーとログインしているユーザーが等しくなかったら
  		redirect_to recipes_path, alert: "不正なアクセスです" #レシピの一覧画面に遷移させます。
  	end
  end

  def update
  	@recipe = Recipe.find(params[:id])
  	if @recipe.update(recipe_params)
  	redirect_to recipe_path(@recipe), notice: '更新に成功しました'
  else
  	render :edit
  end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end


  private
  def recipe_params #recipe_params
  	params.require(:recipe).permit(:title, :body, :image)
  end

end
