require 'opsview_rest/mixin'

class OpsviewRest
  class Hostgroup
    include OpsviewRest::Mixin

    attr_accessor :opsview, :options, :resource_type

    def initialize(opsview, options = {})
      @options = {
        parent: 'Opsview',
        name: 'unknown',
        save: true,
        replace: false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:parent] = { 'name' => @options[:parent] }
      @options[:hosts] = @options[:hosts].map { |x| { 'name' => x } }
      @options[:children] = @options[:children].map { |x| { 'name' => x } }

      save(@options[:replace]) if @options[:save]
    end
  end
end
