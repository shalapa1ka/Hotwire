# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      @session = user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }
      flash[:info] = 'Signed in successfully'
      redirect_to root_path
    else
      flash[:danger] = 'That email or password is incorrect'
      redirect_to sign_in_path(email_hint: params[:email])
    end
  end

  def destroy
    @session.destroy
    flash[:info] = 'That session has been logged out'
    redirect_to sessions_path
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
  end
end
