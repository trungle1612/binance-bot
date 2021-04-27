class BaseError < StandardError
  attr_reader :error

  def code
    raise NotImplementedError
  end

  def status
    raise NotImplementedError
  end

  def data
    {}
  end

  def to_json
    {
      errors: {
        message: error,
        code: code,
        status: status,
        data: data
      }
    }
  end
end
