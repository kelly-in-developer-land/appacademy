require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    where_line = params.keys.map { |col| "#{col} = ?" }.join(" AND ")
    search_terms = params.values

    search_results = DBConnection.execute(<<-SQL, *search_terms)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{where_line}
    SQL

    return nil if search_results.nil?
    parse_all(search_results)
  end
end

class SQLObject
  extend Searchable
end
