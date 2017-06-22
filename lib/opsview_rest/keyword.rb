require 'opsview_rest/mixin'

class OpsviewRest
  class Keyword
    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        name: 'Unknown',
        all_hosts: false,
        hosts: [],
        roles: ['View some, change none'],
        all_servicechecks: false,
        servicechecks: [],
        description: '',
        style: 'group_by_host',
        enabled: true,
        save: true,
        replace: false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:all_hosts] = (@options[:all_hosts] ? 1 : 0)
      @options[:all_servicechecks] = (@options[:all_servicechecks] ? 1 : 0)
      @options[:enabled] = (@options[:enabled] ? 1 : 0)
      @options[:servicechecks] = @options[:servicechecks].map { |x| { 'name' => x } }
      @options[:hosts] = @options[:hosts].map { |x| { 'name' => x } }
      @options[:roles] = @options[:roles].map { |x| { 'name' => x } }

      save(@options[:replace]) if @options[:save]
    end
  end
end
