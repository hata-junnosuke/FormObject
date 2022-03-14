class FormatsController < ApplicationController
  def index
    @formats = User.all
  end

  def new
    @format = User.new
  end

  def create
    @format = User.create(format_params)
    redirect_to root_path
  end

  private
  def format_params
    params.require(:user).permit(:name, :name_kana, :nickname)
  end
end