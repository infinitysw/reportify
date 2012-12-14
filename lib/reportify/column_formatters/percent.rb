module Reportify
  module ColumnFormatters

    class Percent < ColumnFormat
      include ActionView::Helpers::NumberHelper

      def format(val, options={})
        return val unless is_valid_num?(val)
        number_to_percentage(val.to_f, {:precision=>2}.merge(options))
      end

    end
  end
end
