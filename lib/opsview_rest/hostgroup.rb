class OpsviewRest
  class Hostgroup

    include OpsviewRest::Util

    attr_accessor :name, :id, :parent, :hosts, :children, :opsview

    def initialize(opsview, options = {})
      options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @name     = options[:name]
      @parent   = options[:parent]
      @hosts    = options[:hosts]
      @children = options[:children]

      save(options[:replace]) if options[:save]
    end

    # Main thing to change if we need to change the schema of the
    # stuff we want to send through the API.
    def to_json
      {
        "name"     => @name,
        "parent"   => {
          "name" => @parent
        },
        "children" => @children.map { |x| { "name" => x } },
        "hosts"    => @hosts.map { |x| { "name" => x } }
      }.to_json
    end

  end
end
