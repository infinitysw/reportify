module Reportify
  module ColumnFormatters
    class DateFormat < ColumnFormat
      def format(val, options = {})
        return "" if val.nil?
        val = Date.parse(val) unless val.is_a?(Date) || val.is_a?(Time)
        options[:format].present? ? val.strftime(options[:format]) : val.to_date.to_s
      end
    end
  end
end
