# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_user

  def edit; end

  def update
    if !@user.authenticate(params[:current_password])
      flash[:danger] = 'The current password you entered is incorrect'
      redirect_to edit_password_path
    elsif @user.update(user_params)
      flash[:info] = 'Your password has been changed'
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
