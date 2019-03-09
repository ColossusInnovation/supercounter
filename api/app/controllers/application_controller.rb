class ApplicationController < ActionController::API
  rescue_from Mongoid::Errors::Validations do |e|
    respond_error(:invalid_input, 400, e.to_s)
  end
  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    respond_error(:not_found, 404, e.to_s)
  end

  private
  def respond_error(error, status, message)
    render json: {
      error: error,
      status: status,
      message: message
    }.as_json, status: status
  end
end
