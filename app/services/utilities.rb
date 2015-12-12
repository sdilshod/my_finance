# -*- encoding: utf-8 -*-

module Utilities

  def self.get_db_tables_information
    table_names = ActiveRecord::Base.connection.tables
    sql_str = ''
    table_names.each do |name|
      if table_names.index(name) == 0
        sql_str = "select '#{name}' as table_name, count(*) as count from #{name}"
      else
        sql_str << " union select '#{name}', count(*) from #{name}"
      end
    end

    #TODO need to include total sum as 1C support if it support in postgres
    return ActiveRecord::Base.connection.execute "select * from (#{sql_str}) as sub_query order by count desc"
  end
end
