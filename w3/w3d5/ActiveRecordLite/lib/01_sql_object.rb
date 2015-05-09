require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject

  def self.columns
    return @columns if @columns
    names = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{table_name}
    SQL
    col_names = names.map(&:to_sym)
    @columns = col_names
  end

  def self.finalize!
    columns.each do |attr_name|
      define_method("#{attr_name}") do
        attributes[attr_name]
      end
      define_method("#{attr_name}=") do |value|
        attributes[attr_name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "#{self.to_s.tableize}"
  end

  def self.all
    all_attrs = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    parse_all(all_attrs)
  end

  def self.parse_all(results)
    results.map do |attrs_hash|
      new(attrs_hash)
    end
  end

  def self.find(id)
    finder_query_result = DBConnection.execute2(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
      LIMIT
        1
    SQL
    return nil if finder_query_result.length < 2

    new(finder_query_result.last)
  end

  def initialize(params = {})
    @attributes = {}
    params.each_pair do |attr_name, value|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      @attributes[attr_name.to_sym] = value
    end
  end

  def attributes
    @attributes
  end

  def attribute_values
    self.class.columns.map { |attr_name| self.send(attr_name) }
  end

  def insert
    cols = self.class.columns.drop(1)
    insertion_cols = cols.map(&:to_s).join(", ")
    question_marks = [["?"]*cols.length].join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{insertion_cols})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.drop(1).map { |col| "#{col} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
