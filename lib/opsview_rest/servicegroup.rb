require 'opsview_rest/mixin'

class OpsviewRest
  class Servicegroup

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => "Unknown",
        :servicechecks => [ "" ],
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:servicechecks] = @options[:servicechecks].map { |x| { "name" => x } }

      save(@options[:replace]) if @options[:save]
    end

  end
end
