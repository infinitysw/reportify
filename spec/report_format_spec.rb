require 'spec_helper'

describe Reportify::ReportFormat do

  describe 'create' do

    it 'should create an object of the given type' do
      Reportify::ReportFormat.create('ruby_csv').class.should == Reportify::ReportFormatters::RubyCsv
      Reportify::ReportFormat.create('html_table').class.should == Reportify::ReportFormatters::HtmlTable
      Reportify::ReportFormat.create('HtmlTable').class.should == Reportify::ReportFormatters::HtmlTable
    end

    it 'should raise an exception if a formatter name is given that does not exist' do
      lambda {Reportify::ReportFormat.create('not_real_formatter')}.should raise_error(NameError)
    end

  end

end
