module Reportify
  module ColumnFormatters

    class WholeNumber < ColumnFormat
      include ActionView::Helpers::NumberHelper

      def format(val, options={})
        return val unless is_valid_num?(val)
        number_with_precision(val, {:precision=>0}.merge(options))
      end

    end
  end
end
