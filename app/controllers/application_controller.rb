class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :authenticate!

  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }


  private

  	def authenticate!
  		authenticate_token #|| render_unauthorized	
  	end

  	def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(authentication_token: token)
      end
    end

    #def render_unauthorized
    #  render json: {
    #    errors: ['Bad credentials']
    #  }, status: 401
    #end

end
