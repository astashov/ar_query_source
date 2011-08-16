require 'active_record/connection_adapters/mysql_adapter'

module ArQuerySource

  IGNORED_QUERIES = /^show/i
  mattr_accessor :enabled
  self.enabled = true

  def self.get_first_line_from_app
    line = caller.find { |l| l.match(/#{Rails.root}\/((?!vendor).)*$/) }
    line.to_s.gsub(/#{Rails.root}\//, "")
  end

end

module ActiveRecord
  module ConnectionAdapters
    class MysqlAdapter < AbstractAdapter
      private

      def execute_with_ar_query_source(sql, name = nil)
        result = execute_without_ar_query_source(sql, name)
        if ArQuerySource.enabled && sql !~ ArQuerySource::IGNORED_QUERIES
          calling_line = ArQuerySource.get_first_line_from_app
          @logger.debug(calling_line + "\n") if @logger && !calling_line.blank?
        end
        result
      end

      alias_method_chain :execute, :ar_query_source

    end
  end
end 
