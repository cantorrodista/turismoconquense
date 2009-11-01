module Nicenamed
  def self.included(base)
    base.class_eval do
      validates_presence_of :name
      before_save :set_nicename
    end
  end

  def set_nicename
    if self.respond_to? :published?
      if self.published? and self.date.blank?
        self.date = Time.now 
        self.nicename = self.name.parameterize if self.nicename.blank?
      else
        self.nicename = self.name.parameterize if self.nicename.blank?
      end
    else
      self.nicename = self.name.parameterize if self.nicename.blank?
    end
  end

  def to_param
    "#{self.nicename}-#{self.id}"
  end
end

module NicenamedResource
  def self.extract_id(string)
    string[/^.*-(\d+)$/, 1]
  end

  def self.extract_nicename_and_id(string)
    if string =~ /^(.*)-(\d+)$/
      [$1, $2]
    else
      [nil, nil]
    end
  end
    
  private
    
    def resource
      instance_name = '@' + self.class.name[0..-11].classify.underscore
      instance_variable_get(instance_name) || set_resource(instance_name)
    end

    def set_resource(instance_name)
      nicename, id = NicenamedResource.extract_nicename_and_id(params[:id])
      if nicename and id
        obj = end_of_association_chain.find_by_id(id)
        instance_variable_set(instance_name, obj) if obj.nicename == nicename
      end
    end
end
