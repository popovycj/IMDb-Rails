class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
  end
end
