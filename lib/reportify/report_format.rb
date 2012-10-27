module Reportify
  class ReportFormat

    def self.create(name)
      begin
        class_name = "Reportify::ReportFormatters::#{name.classify}"
        eval(class_name).new
      rescue Exception => e
        raise NameError, "Attempt made to build a report formatter named: #{class_name}, but this class doesn't exist."
      end
    end

  end
end