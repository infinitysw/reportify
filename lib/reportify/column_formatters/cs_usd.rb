# CountryStone price columns are typically stored as price in cents and with a precision of 5.
# This formatter takes that in to account when creating a USD value from a given number
module Reportify
  module ColumnFormatters

    class CsUsd < ColumnFormat
      include ActionView::Helpers::NumberHelper

      PRECISION_ADJUSTMENT = 100000

      def format(val, options = {})
        return val unless is_valid_num?(val)
        number_to_currency((val.respond_to?('to_d') ? val.to_d : BigDecimal(val.to_s)) / PRECISION_ADJUSTMENT, options)
      end

    end

  end
end
