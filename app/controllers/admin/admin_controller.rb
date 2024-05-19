# frozen_string_literal: true
module Admin
  class AdminController < ApplicationController
    layout "admin"
    prepend_before_action :is_admin

    private

    def is_admin
      return if current_user&.admin?

      flash[:danger] = t("application.user.is_not_admin")
      redirect_to root_path
    end
  end
end