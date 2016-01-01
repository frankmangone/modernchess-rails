class BaseApiController < ApplicationController
	
  skip_before_filter :verify_authenticity_token

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  #before_filter :parse_request, :authenticate_user_from_token!

  #private
  #  def authenticate_user_from_token!
  #    if !@json['api_token']
  #      render nothing: true, status: :unauthorized
  #    else
  #      @user = nil
  #      User.find_each do |u|
  #        if Devise.secure_compare(u.api_token, @json['api_token'])
  #          @user = u
  #        end
  #      end
  #    end
  #  end

  #  def parse_request
  #    @json = JSON.parse(request.body.read)
  #  end
end
