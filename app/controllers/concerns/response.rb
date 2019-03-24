module Response
  def response_json(object, status = :ok)
    render json: object, status: status
  end
end
