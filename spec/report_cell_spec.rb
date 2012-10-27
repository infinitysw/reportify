require 'spec_helper'

describe Reportify::ReportCell do

  before (:each) do
    @rep_column = mock('mock report column')
    @original_value = 'Original'
    @report_cell = Reportify::ReportCell.new(@rep_column, @original_value)
  end

  describe 'formatted_value' do

    it 'should return the orginal value when the report column has no designated formatter' do
      @rep_column.expects(:formatter).returns(nil)
      @rep_column.expects(:format_value).never
      @report_cell.formatted_value.should == @original_value
    end

    it 'should use the report columns formatter when it exists' do
      formatter = mock('mock formatter')
      @rep_column.expects(:formatter).returns(formatter)
      @rep_column.expects(:format_value)

      @report_cell.formatted_value
    end

  end

end
