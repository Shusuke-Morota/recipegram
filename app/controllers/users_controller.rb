class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  	@users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: "不正なアクセスです"
    end
  end

  def update
  	@user = User.find(params[:id])# findメソッドでどのユーザーを更新するかを見つけてきて@userに入れる
  	if @user.update(user_params)# @userを更新します
  	redirect_to user_path(@user), notice: '更新に成功しました'# ユーザーの詳細画面に戻ります
  else
    render :edit
  end
  end

  private
  def user_params #user_paramsの定義する。どのカラムをアップデートするのかは以下の４つのカラム。
  	params.require(:user).permit(:username, :email, :profile, :profile_image)
  end #private以下に記述すると、user_controller内でしか呼び出せなくなる→セキュリティの強化
end