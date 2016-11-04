require 'opsview_rest/mixin'

class OpsviewRest
  class Keyword

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name => 'Unknown',
        :all_hosts => false,
        :hosts => [],
        :roles => ['View some, change none'],
        :all_servicechecks => false,
        :servicechecks => [],
        :description => '',
        :style => 'group_by_host',
        :enabled => true,
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:all_hosts] = if @options[:all_hosts] then 1 else 0 end
      @options[:all_servicechecks] = if @options[:all_servicechecks] then 1 else 0 end
      @options[:enabled] = if @options[:enabled] then 1 else 0 end
      @options[:servicechecks] = @options[:servicechecks].map { |x| { 'name' => x } }
      @options[:hosts] = @options[:hosts].map { |x| { 'name' => x } }
      @options[:roles] = @options[:roles].map { |x| { 'name' => x } }

      save(@options[:replace]) if @options[:save]
    end

  end
end
