class OpsviewRest
  class Attribute

    include OpsviewRest::Mixin

    attr_accessor :options, :opsview

    def initialize(opsview, options = {})
      @options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      save(@options[:replace]) if @options[:save]
    end

  end
end
