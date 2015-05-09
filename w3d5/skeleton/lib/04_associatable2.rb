require_relative '03_associatable'

# Phase IV
module Associatable

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      guardian_f_key = through_options.send(:foreign_key)
      guardian_f_key_value = @attributes[guardian_f_key]

      one_had = DBConnection.execute(<<-SQL, guardian_f_key_value)
        SELECT
          #{source_options.table_name}.*
        FROM
          #{through_options.table_name}
        JOIN
          #{source_options.table_name} ON #{source_options.table_name}.#{source_options.primary_key} = #{source_options.send(:foreign_key)}
        WHERE
          #{through_options.table_name}.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.new(one_had.first)
    end
  end
end
