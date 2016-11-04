require 'rest-client'
require 'json'

class OpsviewRest

  attr_accessor :url, :username, :password, :rest

  def initialize(url, options = {})
    options = {
      :username => 'api',
      :password => 'changeme',
      :connect  => true
    }.update options

    @url      = url
    @username = options[:username]
    @password = options[:password]
    @rest     = RestClient::Resource.new("#{@url}/rest/", :headers => { :content_type => 'application/json' })

    login if options[:connect]
  end

  def login
    response = post('login', { 'username' => @username, 'password' => @password })
    @rest.headers[:x_opsview_token]    = response['token']
    @rest.headers[:x_opsview_username] = @username
    response
  end

  def logout
    delete('login')
  end

  def create(options = {})
    case options[:type]
    when :attribute
      require 'opsview_rest/attribute'
      OpsviewRest::Attribute.new(self, options)
    when :contact
      require 'opsview_rest/contact'
      OpsviewRest::Contact.new(self, options)
    when :host
      require 'opsview_rest/host'
      OpsviewRest::Host.new(self, options)
    when :hostcheckcommand
      require 'opsview_rest/hostcheckcommand'
      OpsviewRest::Hostcheckcommand.new(self, options)
    when :hostgroup
      require 'opsview_rest/hostgroup'
      OpsviewRest::Hostgroup.new(self, options)
    when :hosttemplate
      require 'opsview_rest/hosttemplate'
      OpsviewRest::Hosttemplate.new(self, options)
    when :keyword
      require 'opsview_rest/keyword'
      OpsviewRest::Keyword.new(self, options)
    when :monitoring_server
      require 'opsview_rest/monitoring_server'
      OpsviewRest::MonitoringServer.new(self, options)
    when :notificationmethod
      require 'opsview_rest/notificationmethod'
      OpsviewRest::NotificationMethod.new(self, options)
    when :role
      require 'opsview_rest/role'
      OpsviewRest::Role.new(self, options)
    when :servicecheck
      require 'opsview_rest/servicecheck'
      OpsviewRest::Servicecheck.new(self, options)
    when :servicegroup
      require 'opsview_rest/servicegroup'
      OpsviewRest::Servicegroup.new(self, options)
    when :timeperiod
      require 'opsview_rest/timeperiod'
      OpsviewRest::Timeperiod.new(self, options)
    else
      raise 'Type not implemented yet.'
    end
  end

  def list(options = {})
    options = {
      :type => 'host',
      :rows => 'all'
    }.update options

    get("config/#{options[:type]}?rows=#{options[:rows]}")
  end

  def reload
    get('reload')
  end

  def initiate_reload
    post('reload', {})
  end

  def find(options = {})
    options = {
      :type => nil,
      :rows => 'all',
      :searchattribute => nil
    }.update options

    if options[:searchattribute].nil?
      options[:searchattribute] = 'name'
    end

    if options[:name].nil?
      raise ArgumentError, 'Need to specify the name of the object.'
    else
      get("config/#{options[:type]}?s.#{options[:searchattribute]}=#{options[:name]}&rows=#{options[:rows]}")
    end
  end

  def purge(options = {})
    options = {
      :type => 'host',
      :name => nil
    }.update options

    if options[:name].nil?
      raise ArgumentError, 'Need to specify the name of the object.'
    else
      id = find(:type => options[:type], :name => options[:name])[0]['id']
      delete("config/#{options[:type]}/#{id}")
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
      raise "I have #{e.inspect} with #{e.http_code}"
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
    if response['message'] and response['detail']
      raise Opsview::Exceptions::RequestFailed, "Request failed: #{response["message"]}, detail: #{response["detail"]}"
    # If we have a token, return that:
    elsif response['token']
      response
    # If we have a list of objects, return the list:
    elsif response['list']
      response['list']
    else
      response['object']
    end
  end
end
