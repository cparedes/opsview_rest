require 'opsview_rest/mixin'

class OpsviewRest
  class MonitoringServer

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => 'Slave',
        :roles => [],
        :activated => true,
        :monitors => [],
        :nodes => [],
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @option[:roles] = @option[:roles].map { |x| { 'name' => x } }
      @option[:monitors] = @option[:monitors].map { |x| { 'name' => x } }
      @option[:nodes] = @option[:nodes].map { |x| { 'host' => { 'name' => x } } }
      @options[:activated] = if @options[:activated] then 1 else 0 end

      save(@options[:replace]) if @options[:save]
    end

  end
end
