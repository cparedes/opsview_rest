class OpsviewRest
  class Hostgroup

    include OpsviewRest::Mixin

    attr_accessor :opsview, :options

    def initialize(opsview, options = {})
      @options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @options[:parent] = { "name" => @options[:parent] }
      @options[:hosts] = @options[:hosts].map { |x| { "name" => x } }
      @options[:children] = @options[:children].map { |x| { "name" => x } }

      save(@options[:replace]) if @options[:save]
    end

  end
end
