require 'spec_helper'

describe Reportify::ColumnFormatters::WeekOfYear do

  before(:each) do
    @formatter = Reportify::ColumnFormat.create('week_of_year')
    @formatter.stubs(:valid_week_number?).returns(true)
    @formatter.stubs(:valid_year?).returns(true)
  end

  context 'options' do

    it 'should check for a valid woy_year option' do
      @formatter.expects(:valid_year?).with(1901).returns(true)
      @formatter.format(1, {'woy_year'=>1901})
    end

    it 'should check given value is a valid week number' do
      @formatter.expects(:valid_week_number?).with(1)
      @formatter.format(1)
    end

    it 'should check for a valid year' do
      @formatter.expects(:valid_year?)
      @formatter.format(1, {'woy_year'=>2000})
    end

    it 'should check for a valid week number' do
      @formatter.expects(:valid_week_number?)
      @formatter.format(1, {'woy_year'=>2000})
    end

  end

  context 'interface' do

    it 'should use Date.commercial to format year' do
      Date.expects(:commercial).returns(Date.new)
      @formatter.stubs(:end_of_week)
      @formatter.format(1, {'woy_year'=>2000})
    end

    it 'should convert the week_number into an int' do
      week_num = mock()
      week_num.expects(:to_i).returns(1)
      @formatter.format(week_num, {'woy_year'=>2000})
    end

    it 'should find the end of the week given' do
      date_mock = Date.new
      Date.expects(:commercial).returns(date_mock)
      date_mock.expects(:end_of_week).returns(1)
      @formatter.format(1, {'woy_year'=>2000})
    end

  end

end
