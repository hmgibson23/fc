class HomeAction < Cramp::Action
  def start
    data = params[:data]
    ip = request.ip
    res = { :received => data, :ip => ip }.to_json
    render res
    finish
  end

  def respond_with
    [200, {'Content-Type' => 'application/json'}]
  end
end
