module Reportify
  class ColumnFormat

    def self.create(name)
      begin
        class_name = "Reportify::ColumnFormatters::#{name.classify}"
        eval(class_name).new
      rescue Exception => e
        raise NameError, "Attempt made to build a column formatter named: #{class_name}, but this class doesn't exist."
      end
    end

    protected

    def is_valid_num?(value)
      !!(value.to_s =~ /^[-+]?[0-9]*\.?[0-9]+$/)
    end

    def valid_year?(value, valid_start=1900, valid_end=2500)
      valid_int_range?(value, valid_start, valid_end)
    end

    def valid_week_number?(value)
      valid_int_range?(value, 0, 52)
    end

    def valid_int_range?(value, start_range, end_range)
      begin
        (start_range..end_range).cover?(Integer(value))
      rescue Exception => e
        false
      end
    end

  end
end
