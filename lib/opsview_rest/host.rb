require 'opsview_rest/mixin'

class OpsviewRest
  class Host
    include OpsviewRest::Mixin

    attr_accessor :options, :opsview, :resource_type

    def initialize(opsview, options = {})
      # Default set of attributes to send to Opsview:
      @options = {
        flap_detection_enabled: false,
        snmpv3_privprotocol: nil,
        hosttemplates: [],
        keywords: [],
        check_period: '24x7',
        hostattributes: [],
        notification_period: '24x7',
        name: 'unknown',
        rancid_vendor: nil,
        snmp_community: 'public',
        hostgroup: 'Unknown',
        enable_snmp: false,
        monitored_by: 'Master Monitoring Server',
        alias: 'Managed Host',
        uncommitted: false,
        parents: [],
        icon: { 'name' => 'LOGO - Opsview' },
        retry_check_interval: 1,
        ip: 'localhost',
        use_mrtg: false,
        servicechecks: [],
        use_rancid: false,
        nmis_node_type: 'router',
        snmp_version: '2c',
        snmp_authpassword: '',
        use_nmis: false,
        rancid_connection_type: 'ssh',
        snmpv3_authprotocol: nil,
        rancid_username: nil,
        rancid_password: nil,
        check_command: 'ping',
        check_attempts: 2,
        check_interval: 0,
        notification_interval: 60,
        snmp_port: 161,
        snmpv3_username: '',
        snmpv3_privpassword: '',
        other_addresses: '',
        save: true,
        replace: false
      }.update options

      @opsview = opsview
      @resource_type = @options[:type]

      # Add any weird exceptions here (like hostgroups having to be mapped
      # to "name" => hostgroup, etc.):
      @options[:flap_detection_enabled] = (@options[:flap_detection_enabled] ? 1 : 0)
      @options[:enable_snmp] = (@options[:enable_snmp] ? 1 : 0)
      @options[:use_mrtg] = (@options[:use_mrtg] ? 1 : 0)
      @options[:use_rancid] = (@options[:use_rancid] ? 1 : 0)
      @options[:use_nmis] = (@options[:use_nmis] ? 1 : 0)
      @options[:uncommitted] = (@options[:uncommitted] ? 1 : 0)
      @options[:check_period] = { 'name' => @options[:check_period] }
      @options[:hostgroup] = { 'name' => @options[:hostgroup] }
      @options[:notification_period] = { 'name' => @options[:notification_period] }
      @options[:monitored_by] = { 'name' => @options[:monitored_by] }
      @options[:servicechecks] = @options[:servicechecks].map { |x| { 'name' => x } }
      @options[:check_command] = { 'name' => @options[:check_command] }

      save(@options[:replace]) if @options[:save]
    end
  end
end
