# frozen_string_literal: true

require 'application_system_test_case'

module Identity
  class PasswordResetsTest < ApplicationSystemTestCase
    setup do
      @user = users(:lazaro_nixon)
      @sid = @user.password_reset_tokens.create.signed_id(expires_in: 20.minutes)
    end

    test 'sending a password reset email' do
      visit sign_in_url
      click_on 'Forgot your password?'

      fill_in 'Email', with: @user.email
      click_on 'Send password reset email'

      assert_text 'Check your email for reset instructions'
    end

    test 'updating password' do
      visit edit_identity_password_reset_url(sid: @sid)

      fill_in 'New password', with: 'Secret6*4*2*'
      fill_in 'Confirm new password', with: 'Secret6*4*2*'
      click_on 'Save changes'

      assert_text 'Your password was reset successfully. Please sign in'
    end
  end
end
