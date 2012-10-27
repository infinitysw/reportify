require 'spec_helper'

describe Reportify::ColumnFormat do

  describe 'create' do

    it 'should create an object of the given type' do
      Reportify::ColumnFormat.create('percent').class.should == Reportify::ColumnFormatters::Percent
      Reportify::ColumnFormat.create('week_of_year').class.should == Reportify::ColumnFormatters::WeekOfYear
      Reportify::ColumnFormat.create('WeekOfYear').class.should == Reportify::ColumnFormatters::WeekOfYear
    end

    it 'should raise an exception if a formatter name is given that does not exist' do
      lambda {Reportify::ColumnFormat.create('not_real_formatter')}.should raise_error(NameError)
    end

  end

end
