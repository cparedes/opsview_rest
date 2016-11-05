class OpsviewRest
  module Mixin
    def resource_path(full = false)
      if full == true || full == :full
        "/rest/config/#{resource_type}"
      else
        "config/#{resource_type}"
      end
    end

    def save(replace = false)
      if replace == true || replace == :replace
        opsview.put(resource_path, self)
      else
        opsview.post(resource_path, self)
      end
    end

    def to_json
      options.to_json
    end
  end
end
