require 'opsview_rest/mixin'

class OpsviewRest
  class Hostcheckcommand

    include OpsviewRest::Mixin

    attr_accessor :opsview, :options

    def initialize(opsview, options = {})
      @options = {
        :name => "ping",
        :args => "-H $HOSTADDRESS$ -t 3 -w 500.0,80% -c 1000.0,100%",
        :priority => 1,
        :plugin => "check_icmp",
        :uncommitted => false,
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @options[:plugin] = { "name" => @options[:plugin] }
      @options[:hosts] = @options[:hosts].map { |x| { "name" => x } }
      @options[:uncommitted] = if @options[:uncommitted] then 1 else 0 end

      save(@options[:replace]) if @options[:save]
    end

  end
end
