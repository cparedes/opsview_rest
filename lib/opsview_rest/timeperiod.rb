require 'opsview_rest/mixin'

class OpsviewRest
  class Timeperiod

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => "nonworkhours",
        :monday => "00:00-09:00,17:00-24:00",
        :tuesday => "00:00-09:00,17:00-24:00",
        :wednesday => "00:00-09:00,17:00-24:00",
        :thursday => "00:00-09:00,17:00-24:00",
        :friday => "00:00-09:00,17:00-24:00",
        :saturday => "00:00-24:00",
        :sunday => "00:00-24:00",
        :servicecheck_notification_periods => [],
        :servicecheck_check_periods => [],
        :host_check_periods => [],
        :alias => "Non-work hours",
        :host_notification_periods => [],
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @option[:servicecheck_notification_periods] = @option[:servicecheck_notification_periods].map { |x| { "name" => x } }
      @option[:servicecheck_check_periods] = @option[:servicecheck_check_periods].map { |x| { "name" => x } }
      @option[:host_check_periods] = @option[:host_check_periods].map { |x| { "name" => x } }
      @option[:host_notification_periods] = @option[:host_notification_periods].map { |x| { "name" => x } }

      save(@options[:replace]) if @options[:save]
    end

  end
end
