# frozen_string_literal: true
class FavoriteFieldTypesController < ApplicationController
  load_and_authorize_resource

  layout "guest"

  before_action :logged_in_user, :load_dom_id, only: :create
  def index
    @favorites = current_user.favorite_field_types.map(&:field_type)
  end

  def create
    handle_error_and_redirect do
      @favorite = FavoriteFieldType.find_by(field_type_id: params[:field_type_id], user_id: current_user.id)
      if @favorite
        respond_to do |format|
          if @favorite.destroy
            format.html { redirect_to field_path, notice: t("fields.favorite_success") }
          else
            format.html { redirect_to field_path, notice: t("fields.favorite_fail") }
          end
          format.turbo_stream
        end
      else
        @favorite = current_user.favorite_field_types.new(field_type_id: params[:field_type_id])
        respond_to do |format|
          if @favorite.save
            format.html { redirect_to field_path, notice: t("fields.favorite_success") }
          else
            format.html { redirect_to field_path, notice: t("fields.favorite_fail") }
          end
          flash[:success] =  t("fields.favorite_success")
          format.turbo_stream
        end
      end

    end
  end

  private

  # Assign DOM to replace itself
  def load_dom_id
    @dom_id = params[:dom_id]
  end
end
