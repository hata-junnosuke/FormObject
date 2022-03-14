class FormatsController < ApplicationController
  def index
    @formats = Company.includes(:user).all
  end

  def new
    @format = CompanyUser.new
  end

  def create
    @format = CompanyUser.new(format_params)
    if @format.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def format_params
    params.require(:company_user).permit(company_attributes: %i[name address], user_attributes: %i[user_name email password password_confirmation])
  end
end