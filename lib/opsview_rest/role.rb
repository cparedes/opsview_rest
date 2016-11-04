require 'opsview_rest/mixin'

class OpsviewRest
  class Role
    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        name: 'Unknown',
        description: '',
        all_hostgroups: true,
        all_servicegroups: true,
        all_keywords: false,
        access_hostgroups: [],
        access_servicegroups: [],
        access_keywords: [],
        hostgroups: [],
        monitoringservers: [],
        accesses: %w(NOTIFYSOME PASSWORDSAVE VIEWALL),
        save: true,
        replace: false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:hostgroups] = @options[:hostgroups].map { |x| { 'name' => x } }
      @options[:monitoringservers] = @options[:monitoringservers].map { |x| { 'name' => x } }
      @options[:accesses] = @options[:accesses].map { |x| { 'name' => x } }
      @options[:all_hostgroups] = (@options[:all_hostgroups] ? 1 : 0)
      @options[:all_servicegroups] = (@options[:all_servicegroups] ? 1 : 0)
      @options[:all_keywords] = (@options[:all_keywords] ? 1 : 0)

      save(@options[:replace]) if @options[:save]
    end
  end
end
