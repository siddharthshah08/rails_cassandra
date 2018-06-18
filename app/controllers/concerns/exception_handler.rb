module ExceptionHandler
  extend ActiveSupport::Concern

  class BadRequestError < StandardError; end
  class RecordNotFound < StandardError; end
  class RecordInvalid < StandardError; end

  included do
    rescue_from ExceptionHandler::BadRequestError do |e|
      json_response({ error: e.message, code: '400' }, :bad_request)
    end

    rescue_from ExceptionHandler::RecordNotFound do |e|
      json_response({ error: e.message, code: '404' }, :not_found)
    end

    rescue_from ExceptionHandler::RecordInvalid do |e|
      json_response({ error: e.message, code: '422' }, :unprocessable_entity)
    end
  end
end
