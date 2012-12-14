require 'spec_helper'

describe Reportify::ColumnFormatters::Percent do

  before(:each) do
    @formatter = Reportify::ColumnFormat.create('percent')
  end

  context 'options' do

    it 'should default the precision to 2' do
      @formatter.expects(:number_to_percentage).with(10,{:precision=>2})
      @formatter.format(10)
    end

    it 'should merge options with the defaults' do
      @formatter.expects(:number_to_percentage).with(10,{:precision=>2, :test=>true})
      @formatter.format(10, {:test=>true})
    end

    it 'should override defaults with given options' do
      @formatter.expects(:number_to_percentage).with(10,{:precision=>4})
      @formatter.format(10, {:precision=>4})
    end

  end

  context 'value handling' do

    it 'should check to see if a valid number was passed for value' do
      @formatter.expects(:is_valid_num?).with(10)
      @formatter.format(10)
    end

    it 'should return orignal value if its not a valid number' do
      @formatter.format('fail').should == 'fail'
    end

  end

end
