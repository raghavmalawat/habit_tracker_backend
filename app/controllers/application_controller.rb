class ApplicationController < ActionController::API
  include RequestExceptionHandler

  around_action :exception_handling
  attr_reader :jwt_token_payload

  def render_error(error_message, status, other_data = {})
    render json: { message: error_message }.merge(other_data), status: status
  end

  def current_user_id
    token = request.headers['Authorization'].split('Bearer').last.strip
    @jwt_token_payload ||= JwtService.new.decode(token)
    @current_user_id ||= jwt_token_payload['user_id']
  rescue StandardError
    raise UnauthorizedError, 'Unauthorized'
  end

  def client_has_valid_token?
    !!current_user_id
  end

  def require_login
    raise UnauthorizedError, 'Unauthorized' unless client_has_valid_token?
  end

  def token(user_id)
    payload = { user_id: user_id }
    JwtService.new.encode(payload)
  end
end
