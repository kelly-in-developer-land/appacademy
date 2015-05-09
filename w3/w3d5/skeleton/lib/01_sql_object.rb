require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject

  def self.columns
    whole_table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        '#{self.table_name}'
    SQL
    col_names = whole_table.first.map { |col_name| col_name.to_sym }
  end

  def self.finalize!
    columns.each do |col_name|
      define_method("#{col_name}") do
        # instance_variable_get("@#{col_name}")
        self.attributes[col_name]
      end
      define_method("#{col_name}=") do |value|
        # instance_variable_set("@#{col_name}", value)
        self.attributes[col_name] = value
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
        '#{self.table_name}'
    SQL
    parse_all(all_attrs)
  end

  def self.parse_all(results)
    results.map do |attrs_hash|
      self.new(attrs_hash)
    end
  end

  def self.find(id)
    finder_query_result = DBConnection.execute2(<<-SQL, id)
      SELECT
        *
      FROM
        '#{self.table_name}'
      WHERE
        id = ?
      LIMIT
        1
    SQL
    return nil if finder_query_result.length < 2
    self.new(finder_query_result.last)
  end

  def initialize(params = {})
    @attributes = {}
    params.each_pair do |k, v|
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k.to_sym)
      @attributes[k.to_sym] = v
    end
  end

  def attributes
    @attributes
  end

  def attribute_values
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    insertion_cols = ""
    cols = self.class.columns.drop(1)
    cols.each do |col|
      if col == cols.first
        insertion_cols += col.to_s
      else
        insertion_cols += ", " + col.to_s
      end
    end

    question_marks = ""
    cols.length.times do
      question_marks == "" ? question_marks += "?" : question_marks += ", ?"
    end

    v = attribute_values.drop(1)

    DBConnection.execute(<<-SQL, *v)
      INSERT INTO
        #{self.class.table_name} (#{insertion_cols})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.drop(1).map { |col| "#{col} = ?" }.join(", ")
    v = attribute_values.drop(1)
    DBConnection.execute(<<-SQL, *v)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = #{@attributes[:id]}
    SQL
  end

  def save
    @attributes[:id].nil? ? insert : update
  end
end
