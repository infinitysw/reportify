module Reportify
  module ColumnFormatters
    class TimeFormat < ColumnFormat
      def format(val, options = {})
        return "" if val.nil?
        val = Time.parse(val) unless val.is_a?(Date) || val.is_a?(Time)
        options[:format].present? ? val.strftime(options[:format]) : val.to_time.to_s
      end
    end
  end
end
