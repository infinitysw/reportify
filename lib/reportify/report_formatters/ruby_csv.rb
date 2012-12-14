module Reportify
  module ReportFormatters

    class RubyCsv < ReportFormat

      def parse(rows, report_builder)
        CSV.generate do |csv|
          csv << report_builder.headings
          rows.each{|row| csv << row.map{|cell| cell.formatted_value}}
        end
      end

    end

  end
end
