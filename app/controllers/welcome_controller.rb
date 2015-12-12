class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!

  def index; end

  def not_found; render status: '404'; end

  def db_tables_information
    @db_tables_info = Utilities.get_db_tables_information
    @total_count_of_rows = 0
    @db_tables_info.each {|e| @total_count_of_rows += e['count'].to_i }
  end

end
