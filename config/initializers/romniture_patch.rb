ROmniture::Client.class_eval do
  def make_request(method, parameters = {})
    response = send_request(method, parameters)
      
    parsed_response = nil
    begin
      parsed_response = JSON.parse(response.body)
    rescue
      parsed_response = response.body
    end
    
    parsed_response
  end
end