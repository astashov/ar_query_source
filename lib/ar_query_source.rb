module ArQuerySource

  IGNORED_QUERIES = /^show/i
  attr_accessor :enabled
  self.enabled = false

  def get_first_line_from_app
    caller.find { |l| l.match(/#{Rails.root}\/((?!vendor).)*$/) }
  end

end

module ActiveRecord
  module ConnectionAdapters
    class MysqlAdapter < AbstractAdapter
      private

      def execute_with_ar_query_source(sql, name = nil)
        result = execute_without_analyzer(sql, name)
        unless sql =~ ArQuerySource::IGNORED_QUERIES
          if calling_line = ArQuerySource.get_first_line_from_app
            calling_line.gsub!(/#{Rails.root}\//, "")
            @logger.debug(display.to_s + "\n") if @logger
          end
        end
        result
      end
      # Always disable this in production unless you comment this out to do some testing
      alias_method_chain :execute, :ar_query_source

    end
  end
end 
