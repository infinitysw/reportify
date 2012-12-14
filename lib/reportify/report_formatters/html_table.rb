module Reportify
  module ReportFormatters

    class HtmlTable < ReportFormat
      # The view does the heavy lifting on this one.
      # If we get fancier later then you will need to expand this.
      def parse(rows, report_builder)
        rows
      end
    end

  end
end