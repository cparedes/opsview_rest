class OpsviewRest
  class Attribute

    include OpsviewRest::Mixin

    def initialize(opsview, options = {})
      @options = {
        :save    => true,
        :replace => false
      }.update options

      @opsview = opsview

      @options[:all_servicegroups] = 1 if @options[:all_servicegroups] else 0
      @options[:all_hostgroups] = 1 if @options[:all_hostgroups] else 0
      @options[:servicegroups] = @options[:servicegroups].map { |x| { "name" => x } }
      @options[:keywords] = @options[:keywords].map { |x| { "name" => x } }
      @options[:hostgroups] = @options[:hostgroups].map { |x| { "name" => x } }
      @options[:role] = { "name" => @options[:role] }

      save(@options[:replace]) if @options[:save]
    end

  end
end
