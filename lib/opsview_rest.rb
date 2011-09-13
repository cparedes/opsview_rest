class OpsviewRest
  require 'opsview_rest/resource'
  require 'rest_client'
  require 'json'

  attr_accessor :username, :password, :url, :rest

  # Creates an object that's used for interacting with the Opsview
  # REST API.
  def initialize(username, password, url, connect=true)
    @username = username
    @password = password
    @url      = url
    @rest     = RestClient::Resource.new("#{@url}/rest", :headers => { :content_type => 'application/json' })

    login if connect
  end

  def login
    response = post('login', { 'username' => @username, 'password' => @password })
    @rest.headers[:x_opsview_token] = response['token']
    @rest.headers[:x_opsview_username] = @username
    response
  end

  def logout
    delete('login')
  end

  def self.underscore(string)
    word = string.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # Valid resources:

  %w{host contact hosttemplate servicecheck hostgroup notificationmethod role servicegroup}.each do |resource_type|
    define_method underscore(resource_type) do
      OpsviewRest::Resource.new(self,resource_type)
    end
  end

  def get(path_part, additional_headers = {}, &block)
    api_request { @rest[path_part].get(additional_headers, &block) }
  end

  def delete(path_part, additional_headers = {}, &block)
    api_request { @rest[path_part].delete(additional_headers, &block) }
  end

  def post(path_part, payload, additional_headers = {}, &block)
    api_request { @rest[path_part].post(payload.to_json, additional_headers, &block) }
  end

  def put(path_part, payload, additional_headers = {}, &block)
    api_request { @rest[path_part].put(payload.to_json, additional_headers, &block) }
  end

  def api_request(&block)
    response_body = begin
      response = block.call
      response.body
    rescue RestClient::Exception => e
      puts "I have #{e.inspect} with #{e.http_code}"
      if e.http_code == 307
        get(e.response)
      end
      e.response
    end
    parse_response(JSON.parse(response_body))
  end

  def parse_response(response)
    # We've got an error if there's "message" and "detail" fields
    # in the response
    if response["message"] and response["detail"]
      raise Opsview::Exceptions::RequestFailed, "Request failed: #{response["message"]}, detail: #{response["detail"]}"
    # If we have a token, return that:
    elsif response["token"]
      response
    # If we have a list of objects, return the list:
    elsif response["list"]
      response["list"]
    else
      response["object"]
    end
  end
end
