require 'opsview_rest/mixin'

class OpsviewRest
  class NotificationMethod

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => 'Unknown',
        :master => false,
        :active => true,
        :command => 'notify_by_email',
        :contact_variables => 'EMAIL',
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:master] = if @options[:master] then 1 else 0 end
      @options[:active] = if @options[:active] then 1 else 0 end

      save(@options[:replace]) if @options[:save]
    end

  end
end
