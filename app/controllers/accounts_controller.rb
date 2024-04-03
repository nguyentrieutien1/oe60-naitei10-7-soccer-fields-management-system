# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :load_user, only: :activations

  def activations
    handle_error_and_redirect do
      flash[:info] = t "email.activation.activated"
      redirect_to root_path
    end
  end

  private

  def check_activation
    handle_error_and_redirect do
      return if @user.authenticated?(:activation, params[:activation_digest])
    end
  end

  def load_user
    @user = User.find_by activation_digest: params[:activation_digest]
    return if @user

    flash[:danger] = t("model.user.not_found")
    redirect_to root_path
  end
end
