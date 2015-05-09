require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = options[:class_name]
    @class_name ||= name.to_s.camelcase
    @foreign_key = options[:foreign_key]
    @foreign_key ||= "#{name.to_s.singularize}_id".to_sym
    @primary_key = options[:primary_key]
    @primary_key ||= :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @class_name = options[:class_name]
    @class_name ||= name.to_s.singularize.camelcase
    @foreign_key = options[:foreign_key]
    @foreign_key ||= "#{self_class_name.downcase}_id".to_sym
    @primary_key = options[:primary_key]
    @primary_key ||= :id
  end
end

module Associatable
  # Phase IIIb

  def belongs_to(name, options = {})
    o = BelongsToOptions.new(name, options)

    define_method(name) do
      f_key = o.send(:foreign_key)
      f_key_value = @attributes[f_key]
      o.model_class.where({id: f_key_value}).first
    end

    assoc_options[name] = o
  end

  def has_many(name, options = {})
    o = HasManyOptions.new(name, self.to_s, options)

    define_method(name) do
      f_key = o.send(:foreign_key)
      f_key_value = @attributes[:id]
      o.model_class.where({f_key => f_key_value})
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
