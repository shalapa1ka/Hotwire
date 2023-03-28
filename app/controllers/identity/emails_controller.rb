# frozen_string_literal: true

module Identity
  class EmailsController < ApplicationController
    before_action :set_user

    def edit; end

    def update
      if !@user.authenticate(params[:current_password])
        flash[:danger] = 'The current password you entered is incorrect'
        redirect_to edit_identity_email_path
      elsif @user.update(user_params)
        redirect_to_root
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = Current.user
    end

    def user_params
      params.permit(:email)
    end

    def redirect_to_root
      if @user.email_previously_changed?
        resend_email_verification
        flash[:info] = 'Your email has been changed. Please check your inbox to verify your new email address.'
      end
      redirect_to root_path
    end

    def resend_email_verification
      UserMailer.with(user: @user).email_verification.deliver_later
    end
  end
end
