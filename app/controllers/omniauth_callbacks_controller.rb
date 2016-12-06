class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def all
    require 'pry'
    binding.pry
    user = User.from_omni_auth(request.env["omniauth.auth"])
    if user.persisted?
      session[:user_id] = user.id
      current_user
      render json: @current_user
    else
      session["devise.user_attributes"] = user.attributes
      render :json => { :errors => @current_user.errors.full_messages }, :status => 422
    end
  end

  rescue_from OmniauthCallbacksHelper::EmailIdIsNotValid do
    flash[:error] = "Email ID is not valid. Use a valid gmail address."
    render :json => { :errors => @current_user.errors.full_messages }, :status => 422
  end


  private
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end


  alias_method :facebook, :all
end
