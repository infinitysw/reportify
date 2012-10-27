module Reportify
  class ReportColumn

    SUMMARIZE_OPTIONS=['row', 'column', 'both', 'none'].freeze

    attr_accessor :method_name, :display_name, :formatter, :summarize

    # nil formatter means original value will be returned as is.
    def initialize(params)
      self.method_name = params[:method_name]
      self.display_name = params[:display_name] || self.method_name.titleize
      self.formatter = params[:formatter] || nil
      self.summarize = params[:summarize] || 'none'
      self.summarize = 'none' unless SUMMARIZE_OPTIONS.include?(self.summarize)
    end

    def format_value(value, options={})
      (self.formatter.nil?) ? value : self.formatter.format(value, options)
    end

    def has_column_summary?
      (summarize == 'both' || summarize == 'column')
    end

    def has_row_summary?
      (summarize == 'both' || summarize == 'row')
    end

  end
end
