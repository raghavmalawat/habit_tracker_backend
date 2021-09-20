module RequestExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  end

  private

  def exception_handling
    yield
  rescue ArgumentError => e
    render_error(e.message, :unprocessable_entity)
  rescue ActiveRecord::RecordNotFound
    render_not_found_error('Resource not found')
  rescue UnauthorizedError
    render_unauthorized('Unauthorized')
  rescue ActionController::UnpermittedParameters => e
    render_forbidden("You are not allowed to perform this action, #{e.message}")
  end

  def render_forbidden(message)
    render json: { error: message }, status: :forbidden
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  def render_not_found_error(message)
    render json: { error: message }, status: :not_found
  end

  def render_could_not_create_error(message)
    render json: { error: message }, status: :unprocessable_entity
  end

  def render_internal_server_error(message)
    render json: { error: message }, status: :internal_server_error
  end

  def render_record_invalid(exception)
    render json: {
      message: exception.record.errors.full_messages.join(', ')
    }, status: :unprocessable_entity
  end

  def render_error_response(exception)
    render json: exception.to_hash, status: exception.http_status
  end
end
