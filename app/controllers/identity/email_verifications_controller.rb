class Identity::EmailVerificationsController < ApplicationController
  skip_before_action :authenticate, only: :show

  before_action :set_user, only: :show

  def show
    @user.update! verified: true
    flash[:info] = "Thank you for verifying your email address"
    redirect_to root_path
  end

  def create
    send_email_verification
    flash[:info] = "We sent a verification email to your email address"
    redirect_to root_path
  end

  private
    def set_user
      @token = EmailVerificationToken.find_signed!(params[:sid]); @user = @token.user
    rescue
      flash[:danger] = "That email verification link is invalid"
      redirect_to edit_identity_email_path
    end

    def send_email_verification
      UserMailer.with(user: Current.user).email_verification.deliver_later
    end
end
