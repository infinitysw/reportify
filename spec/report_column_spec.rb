require 'spec_helper'

describe Reportify::ReportColumn do

  before (:each) do
    @report_column = Reportify::ReportColumn.new({:method_name=>'meth'})
  end

  describe 'initialize' do

    it 'should default the display name to the method name' do
       @report_column.display_name.should == 'Meth'
    end

    it 'should default the formatter to nil' do
       @report_column.formatter.should == nil
    end

    it "should default summarize to 'none'" do
       @report_column.summarize.should == 'none'
    end

    it "should default summarize to 'none' if an invalid summarize option is given" do
      rc = Reportify::ReportColumn.new({:method_name=>'meth', :summarize=>'fake'})
      rc.summarize.should == 'none'
    end

  end

  describe 'format_value' do

    it 'should return the original value if no formatter exists' do
      val = mock('mock value')
      @report_column.format_value(val).should == val
    end

    it 'should use a formatter if one exists in the object' do
      formatter = mock('mock formatter')
      @report_column.expects(:formatter).twice.returns(formatter)
      formatter.expects(:format)

      @report_column.format_value('value')
    end

  end

  describe 'has_column_summary?' do

    it 'should return true if summarize is either both or column' do
      @report_column.summarize='both'
      @report_column.has_column_summary?.should == true
      @report_column.summarize='column'
      @report_column.has_column_summary?.should == true
      @report_column.summarize='row'
      @report_column.has_column_summary?.should == false
    end

  end

  describe 'has_row_summary?' do

    it 'should return true if summarize is either both or row' do
      @report_column.summarize='both'
      @report_column.has_row_summary?.should == true
      @report_column.summarize='row'
      @report_column.has_row_summary?.should == true
      @report_column.summarize='column'
      @report_column.has_row_summary?.should == false
    end

  end

end
