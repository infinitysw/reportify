require 'spec_helper'

describe Reportify::ReportFormatters::HtmlTable do

  before(:each) do
    @formatter = Reportify::ReportFormat.create('html_table')
    @rows = mock('mock rows')
    @builder = mock('mock builder')
  end

  describe 'parse' do

    it 'should return the given rows as is' do
      @formatter.parse(@rows, @builder).should == @rows
    end

  end

end
