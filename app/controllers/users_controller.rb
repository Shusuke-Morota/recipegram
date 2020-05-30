class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])# findメソッドでどのユーザーを更新するかを見つけてきて@userに入れる
  	@user.update(user_params)# @userを更新します
  	redirect_to user_path(@user)# ユーザーの詳細画面に戻ります
  end

  private
  def user_params #user_paramsの定義する。どのカラムをアップデートするのかは以下の４つのカラム。
  	params.require(:user).permit(:username, :email, :profile, :profile_image)
  end #private以下に記述すると、user_controller内でしか呼び出せなくなる→セキュリティの強化
end