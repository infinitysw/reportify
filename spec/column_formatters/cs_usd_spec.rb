require 'spec_helper'

describe Reportify::ColumnFormatters::CsUsd do

  before(:each) do
    @formatter = Reportify::ColumnFormat.create('cs_usd')
  end

  context 'options' do

    it 'should default the options to an empty hash' do
      @formatter.expects(:number_to_currency).with(1,{})
      @formatter.format(100000)
    end

    it 'should pass given options through to the number_to_currency method' do
      options = {:precision=>4}
      @formatter.expects(:number_to_currency).with(anything, options)
      @formatter.format(100000, options)
    end

  end

  context 'value handling' do

    it 'should check to see if a valid number was passed for value' do
      @formatter.expects(:is_valid_num?).with(100000)
      @formatter.format(100000)
    end

    it 'should see if value given responds to to_d' do
      val = mock('mock-value')
      @formatter.stubs(:is_valid_num?).returns(true)
      val.expects(:respond_to?).with('to_d')
      @formatter.format(val)
    end


    it 'should convert value using to_d when possible' do
      val = mock('mock-value')
      @formatter.stubs(:is_valid_num?).returns(true)
      val.stubs(:respond_to?).returns(true)
      val.expects(:to_d).returns(1)
      @formatter.format(val)
    end

    it 'should create a BigDecimal out of the value when cannot use to_d' do
      val = mock('mock-value')
      @formatter.stubs(:is_valid_num?).returns(true)
      val.stubs(:respond_to?).returns(false)
      val.expects(:to_d).never
      BigDecimal.expects(:new).returns(1)
      @formatter.format(val)
    end

    it 'should return orignal value if its not a valid number' do
      @formatter.format('fail').should == 'fail'
    end

  end

end
