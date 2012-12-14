require 'spec_helper'

describe Reportify::ReportFormatters::RubyCsv do

  before(:each) do
    @formatter = Reportify::ReportFormat.create('ruby_csv')
    @rows = mock('mock rows')
    @builder = mock('mock builder')
    @csv = mock('mock csv')
    @row = mock('mock row')
    @cell = mock('mock cell')

    @csv.stubs(:<<)
    @rows.stubs(:each).returns([])
    @builder.stubs(:headings).returns(@headings)
  end

  describe 'parse' do

    it 'should use the ruby CSV built in lib' do
      CSV.expects(:generate)
      @formatter.parse(@rows, @builder)
    end

    it 'should use the report_builder to find the csv headings' do
      CSV.expects(:generate).yields(@csv)
      @builder.expects(:headings)

      @formatter.parse(@rows, @builder)
    end

    it 'should loop through all the rows given' do
      CSV.expects(:generate).yields(@csv)
      @rows.expects(:each).returns([])

      @formatter.parse(@rows, @builder)
    end

    it 'should extract the formatted_value from the cell' do
      CSV.expects(:generate).yields(@csv)
      @rows.expects(:each).yields(@row)
      @row.expects(:map).yields(@cell)
      @cell.expects(:formatted_value)

      @formatter.parse(@rows, @builder)
    end

  end

end
