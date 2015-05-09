class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}") { instance_variable_get("@#{name}".to_sym) }
      define_method("#{name}=") { |value| instance_variable_set("@#{name}".to_sym, value) }
    end
  end
end
