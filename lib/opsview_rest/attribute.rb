require 'opsview_rest/mixin'

class OpsviewRest
  class Attribute
    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        name: 'PROCESSES',
        arg1: '',
        arg2: '',
        arg3: '',
        arg4: '',
        value: '',
        servicechecks: [],
        save: true,
        replace: false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:servicechecks] = @options[:servicechecks].map { |x| { 'name' => x } }

      save(@options[:replace]) if @options[:save]
    end
  end
end
