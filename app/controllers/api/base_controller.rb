class Api::BaseController < ApplicationController
  before_action :authenticate_user
  #because we are not using sessions to autenticate user but the api key so we need to nullify the session
  protect_from_forgery with: :null_session

  private

  def authenticate_user
    @user = User.find_by_api_key params[:api_key]
    head :forbidden unless @user
  end
end
