require_relative '03_associatable'

# Phase IV
module Associatable

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_f_key_value = @attributes[through_options.send(:foreign_key)]
      source_f_key = source_options.send(:foreign_key)

      source_table = source_options.table_name
      through_table = through_options.table_name

      one_had = DBConnection.execute(<<-SQL, through_f_key_value)
        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table}
          ON #{source_table}.#{source_options.primary_key} = #{source_f_key}
        WHERE
          #{through_table}.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.parse_all(one_had).first
    end
  end
end
