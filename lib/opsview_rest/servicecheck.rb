require 'opsview_rest/mixin'

class OpsviewRest
  class Servicecheck

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => 'Unknown',
        :description => 'Unknown',
        :keywords => [],
        :attribute => nil,
        :servicegroup => 'Unknown',
        :dependencies => [ 'Opsview Agent' ],
        :check_period => '24x7',
        :check_interval => '5',
        :check_attempts => '3',
        :retry_check_interval => '1',
        :plugin => 'check_nrpe',
        :args => '',
        :stalking => nil,
        :volatile => false,
        :invertresults => false,
        :notification_options => 'w,c,r',
        :notification_period => nil,
        :notification_interval => nil,
        :flap_detection_enabled => true,
        :checktype => 'Active Plugin',
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:keywords] = @options[:keywords].map { |x| { 'name' => x } }
      @options[:servicegroup] = { 'name' => @options[:servicegroup] }
      @options[:dependencies] = @options[:dependencies].map { |x| { 'name' => x } }
      @options[:check_period] = { 'name' => @options[:check_period] }
      @options[:plugin] = { 'name' => @options[:plugin] }
      @options[:volatile] = if @options[:volatile] then 1 else 0 end
      @options[:invertresults] = if @options[:invertresults] then 1 else 0 end
      @options[:flap_detection_enabled] = if @options[:flap_detection_enabled] then 1 else 0 end
      @options[:checktype] = { 'name' => @options[:checktype] }

      save(@options[:replace]) if @options[:save]
    end

  end
end
