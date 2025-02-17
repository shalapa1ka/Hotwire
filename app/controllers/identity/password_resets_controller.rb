# frozen_string_literal: true

module Identity
  class PasswordResetsController < ApplicationController
    skip_before_action :authenticate

    before_action :set_user, only: %i[edit update]

    def new; end

    def edit; end

    def create
      if (@user = User.find_by(email: params[:email], verified: true))
        send_password_reset_email
        flash[:info] = 'Check your email for reset instructions'
        redirect_to sign_in_path
      else
        flash[:danger] = "You can't reset your password until you verify your email"
        redirect_to new_identity_password_reset_path
      end
    end

    def update
      if @user.update(user_params)
        revoke_tokens

        flash[:info] = 'Your password was reset successfully. Please sign in'
        redirect_to sign_in_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @token = PasswordResetToken.find_signed!(params[:sid])
      @user = @token.user
    rescue StandardError
      flash[:danger] = 'That password reset link is invalid'
      redirect_to new_identity_password_reset_path
    end

    def user_params
      params.permit(:password, :password_confirmation)
    end

    def send_password_reset_email
      UserMailer.with(user: @user).password_reset.deliver_later
    end

    def revoke_tokens
      @user.password_reset_tokens.delete_all
    end
  end
end
