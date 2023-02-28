class ErrorSerializer
  def self.serialize_error(exception, status, message)
    { message: message, errors: [detail: exception.message, status: status] }
  end
end