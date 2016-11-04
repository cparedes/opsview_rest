require 'opsview_rest/mixin'

class OpsviewRest
  class Contact

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      @options = {
        :name    => 'foobar',
        :fullname => '',
        :description => '',
        :encrypted_password => '$apr1$HTQogYE7$09TNcZWa/WzoBXdUF6Iyr1',
        :realm => 'local',
        :language => '',
        :role => 'View all, change none',
        :variables => [
          { :value => '', :name => 'EMAIL' },
          { :value => 1, :name => 'RSS_COLLAPSED' },
          { :value => 1440, :name => 'RSS_MAXIMUM_AGE' },
          { :value => 30, :name => 'RSS_MAXIMUM_ITEMS' }
        ],
        :notificationprofiles => [
          { :name => '24x7',
            :host_notification_options => 'u,d,r,f',
            :notificationmethods => [
              { :name => 'Email' }
            ],
            :servicegroups => [],
            :all_servicegroups => 1,
            :all_hostgroups => 0,
            :keywords => [],
            :service_notification_options => 'w,c,r,u,f',
            :hostgroups => [],
            :notification_level => 1,
            :notification_period => { :name => '24x7' } },
          { :name => '8x5',
            :host_notification_options => 'u,d,r,f',
            :notificationmethods => [
              { :name => 'Email' }
            ],
            :servicegroups => [],
            :all_servicegroups => 1,
            :all_hostgroups => 0,
            :keywords => [],
            :service_notification_options => 'w,c,r,u,f',
            :hostgroups => [],
            :notification_level => 1,
            :notification_period => { :name => 'workhours' } }
        ],
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      @options[:all_servicegroups] = if @options[:all_servicegroups] then 1 else 0 end
      @options[:all_hostgroups] = if @options[:all_hostgroups] then 1 else 0 end
      @options[:servicegroups] = @options[:servicegroups].map { |x| { 'name' => x } } unless @options[:servicegroups].nil?
      @options[:keywords] = @options[:keywords].map { |x| { 'name' => x } } unless @options[:keywords].nil?
      @options[:hostgroups] = @options[:hostgroups].map { |x| { 'name' => x } } unless @options[:hostgroups].nil?
      @options[:role] = { 'name' => @options[:role] }

      save(@options[:replace]) if @options[:save]
    end

  end
end
