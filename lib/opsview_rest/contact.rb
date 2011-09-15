class OpsviewRest
  class Attribute

    include OpsviewRest::Util

    attr_accessor :opsview, :name, :id, :language, :servicegroups,
                  :variables, :all_servicegroups, :all_hostgroups,
                  :fullname, :keywords, :description, :hostgroups,
                  :notificationprofiles, :realm, :role

    def initialize(opsview, options = {})
      options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @name                 = options[:name]
      @language             = options[:language]
      @servicegroups        = options[:servicegroups]
      @variables            = options[:variables]
      @all_servicegroups    = if options[:all_servicegroups]
                                1
                              else
                                0
      @all_hostgroups       = if options[:all_hostgroups]
                                1
                              else
                                0
      @fullname             = options[:fullname]
      @keywords             = options[:keywords]
      @description          = options[:description]
      @hostgroups           = options[:hostgroups]
      # TODO: Need to rethink this: might be a bit complicated
      # to implement, since there's way more to throw in the variable
      # than just a name.
      #@notificationprofiles = options[:notificationprofiles]
      @realm                = options[:realm]
      @role                 = options[:role]

      save(options[:replace]) if options[:save]
    end

    # Main thing to change if we need to change the schema of the
    # stuff we want to send through the API.
    def to_json
      {
        "name"                 => @name,
        "servicegroups"        => @servicegroups.map { |x| { "name" => x } },
        "all_servicegroups"    => @all_servicegroups,
        "all_hostgroups"       => @all_hostgroups,
        "fullname"             => @fullname,
        "keywords"             => @keywords.map { |x| { "name" => x } },
        "description"          => @description,
        "hostgroups"           => @hostgroups.map { |x| { "name" => x } },
        "realm"                => @realm,
        "role"                 => { "name" => @role }
      }.to_json
    end

  end
end
