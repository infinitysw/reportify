module Reportify
  module ColumnFormatters
    class WeekOfYear < ColumnFormat

      def format(value, options={})
        return value unless valid_week_number?(value) && valid_year?(options['woy_year'])
        "(#{value}) #{(Date.commercial(options['woy_year'].to_i, value.to_i).end_of_week - 1.day)}"
      end

    end
  end
end
