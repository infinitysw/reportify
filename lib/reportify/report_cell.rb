module Reportify
  class ReportCell

    attr_accessor :report_column, :original_value

    def initialize(report_column, original_value)
      self.report_column = report_column
      self.original_value = original_value
    end

    def formatted_value(options={})
      self.report_column.formatter.nil? ? self.original_value : report_column.format_value(self.original_value, options)
    end

  end
end
