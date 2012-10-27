module Reportify
  class Builder
    attr_accessor :report_objects, :report_columns

    def initialize(report_objects, report_columns)
      self.report_objects = report_objects
      self.report_columns = report_columns
    end

    def build(report_formatter, options={})
      rows = []
      self.report_objects.each do |obj|
        rows << self.report_columns.map{|report_column| build_cell(report_column, obj)}
      end

      report_summary(rows)

      report_formatter.parse(rows, self)
    end

    def headings
      headings = self.report_columns.map(&:display_name)
      headings.push 'Total' if has_row_summary?
      headings
    end

    def has_column_summary?
      self.report_columns.any?{|col| col.has_column_summary?}
    end

    def has_row_summary?
      self.report_columns.any?{|col| col.has_row_summary?}
    end

    protected

    # The method name option for a report column can be several styles.
    # Standard -  first_name ( as in User.first_name )
    # Hash     -  first_name ( as in user[:first_name])
    # Nested   -  color.red  ( as in Car.color.red )
    def build_cell(report_column, object)
      if nested_method_name?(report_column.method_name)
        report_column.method_name.split(".").each do |nest|
          object = object.send(nest);
        end
        ReportCell.new(report_column, object)
      elsif object.respond_to?(report_column.method_name)
        ReportCell.new(report_column, object.send(report_column.method_name))
      else
        ReportCell.new(report_column, object[report_column.method_name])
      end
    end

    def nested_method_name?(name)
      (name.split(".").size > 1) ? true : false
    end

    def report_summary(rows)
      return rows unless has_column_summary? || has_row_summary?
      col_total_row = build_column_total(rows)
      rows.each do |row|
        build_row_summary_cell(row) if self.has_row_summary?
        increment_column_total(row, col_total_row) if self.has_column_summary?
      end

      rows << col_total_row if self.has_column_summary?
    end

    def grand_total_available?
      # When doing row and column summaries both, in order for the grand total number ( in the bottom right corner)
      # to make sense you must be summarizing on 'both' for the row and the column.
      # Example on left has all rows and columns summarized, on right shows A, C summed by row, but only B by column showing that a grand total isn't possible.
      # A | B | C      A | B | C
      # 1 | 2 | 3      1 | 2 | 3
      # 2 | 3 | 4      2 | 3 | 4
      # 2 | 5 | 7        | 5 |
      self.report_columns.select{|col| col.has_column_summary? } == self.report_columns.select{|col| col.has_row_summary? }
    end

    def build_column_total(rows)
      return if rows.empty?
      # Create a summary row that is built from the last row of results
      col_total_row = rows.last.map{|cell| ReportCell.new(cell.report_column, cell.report_column.has_column_summary? ? 0 : '' ) }

      # Add the additional cell for the grand total across if a row total is being used
      col_total_row << ReportCell.new(col_total_row.find{|cell| cell.report_column.has_column_summary?}.report_column, 0) if grand_total_available?
      col_total_row
    end

    def build_row_summary_cell(row)
      row_sum = row.reject{|col| !col.report_column.has_row_summary? }.inject(0) {|sum, n| sum + n.original_value.to_i  }
      row.push ReportCell.new(row.find{|cell| cell.report_column.has_row_summary?}.report_column , row_sum)
    end

    def increment_column_total(row, col_total_row)
      row.each_with_index{|cell, index| col_total_row[index].original_value += cell.original_value.to_i if cell.report_column.has_column_summary? && !col_total_row[index].nil? }
    end

  end
end