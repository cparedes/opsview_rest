class OpsviewRest
  class Resource
    # TODO: Sit down and figure out a way to do this better:
    # right now, we're just going to pass in a huge hash with whatever
    # parameters we want, since there's no standard way to update each
    # type of resource, since they all have different parameters.
    attr_accessor :opsview, :name, :resource_type, :record_id, :data

    def initialize(opsview, resource_type, name=nil, record_id=nil, data={})
      @opsview = opsview
      @resource_type = resource_type
      @name = name
      @record_id = record_id
      @data = data
    end

    def [](data_key)
      @data[data_key]
    end

    def []=(data_key, data_value)
      @data[data_key] = data_value
    end

    def name(value=nil)
      value ? (@name = value; self) : @name
    end

    def record_id(value=nil)
      value ? (@record_id = value; self) : @record_id
    end

    def resource_path(full=false)
      if (full == true || full == :full)
        "/rest/config/#{@resource_type}"
      else
        "config/#{@resource_type}"
      end
    end

    def get(name=nil)
      # HACK: Check what type 'name' is.  If it's a string, it's probably
      # something we need to search for.  If it's an integer, it's probably
      # a record ID.
      if name.kind_of? Integer
        raw = @opsview.get("#{resource_path}/#{record_id}")
        OpsviewRest::Resource.new(opsview,
                                  @resource_type,
                                  raw["name"],
                                  raw["id"],
                                  raw)
      elsif name.kind_of? String
        @opsview.get("#{resource_path}?s.name=#{name}", :rows => :all )[0]
      else
        @opsview.get(resource_path)
      end
    end

    def save(replace=false)
      if record_id
        @opsview.put("#{resource_path}/#{record_id}", self)
      else
        if replace == true || replace == :replace
          @opsview.put(resource_path, self)
        else
          @opsview.post(resource_path, self)
        end
      end
      self
    end

    def delete
      url = if record_id
              "#{resource_path}/#{record_id}"
            else
              raise "Can't do that - unimplemented in Opsview API."
            end
      @opsview.delete(url)
    end

    def to_json
      @data.to_json
    end

    def method_missing(method_symbol, *args, &block)
      method_string = method_symbol.to_s
      if (args.length > 0 && method_string !~ /=$/)
        @data[method_string] = args.length == 1 ? args[0] : args
        self
      elsif @data.has_key?(method_string)
        @data[method_string]
      else
        raise NoMethodError, "undefined method `#{method_symbol.to_s}' for #{self.class.to_s}"
      end
    end

  end
end
