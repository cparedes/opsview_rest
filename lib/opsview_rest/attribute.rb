class OpsviewRest
  class Attribute

    include OpsviewRest::Util

    attr_accessor :name, :id, :arg1, :arg2, :arg3, :arg4, :value, :opsview

    def initialize(opsview, options = {})
      options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @name    = options[:name]
      @arg1    = options[:arg1]
      @arg2    = options[:arg2]
      @arg3    = options[:arg3]
      @arg4    = options[:arg4]
      @value   = options[:value]

      save(options[:replace]) if options[:save]
    end

    # Main thing to change if we need to change the schema of the
    # stuff we want to send through the API.
    def to_json
      {
        "name"  => @name,
        "arg1"  => @arg1,
        "arg2"  => @arg2,
        "arg3"  => @arg3,
        "arg4"  => @arg4,
        "value" => @value
      }.to_json
    end

  end
end
