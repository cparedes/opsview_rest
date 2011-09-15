class OpsviewRest
  class Hostcheckcommand

    include OpsviewRest::Mixin

    attr_accessor :opsview, :options

    def initialize(opsview, options = {})
      @options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @options[:plugin] = { "name" => @options[:plugin] }
      @options[:hosts] = @options[:hosts].map { |x| { "name" => x } }

      save(@options[:replace]) if @options[:save]
    end

  end
end
