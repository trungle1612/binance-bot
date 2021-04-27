# frozen_string_literal: true

class ApiCallError < BaseError
  def initialize(error = 'Error when calling API')
    @error = error
  end

  def code
    'API_CALL_ERROR'
  end

  def status
    600
  end
end
