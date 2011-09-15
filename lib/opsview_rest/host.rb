class OpsviewRest
  class Host

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview

    def initialize(opsview, options = {})
      # Default set of attributes to send to Opsview:
      @options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      # Add any weird exceptions here (like hostgroups having to be mapped
      # to "name" => hostgroup, etc.):
      @options[:hostgroup] = { "name" => @options[:hostgroup] }
      @options[:notification_period] = { "name" => @options[:notification_period] }
      @options[:monitored_by] = { "name" => @options[:monitored_by] }
      @options[:servicechecks] = @options[:servicechecks].map { |x| "name" => x }
      @options[:check_command] = { "name" => @options[:check_command] }

      save(@options[:replace]) if @options[:save]
    end

  end
end
