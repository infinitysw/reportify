require 'spec_helper'

describe Reportify::Builder do

  before(:each) do
    @rep_objects = mock('mock report objects')
    @rep_columns = mock('mock report_columns')
    @rep_formatter = mock('mock formatter')

    @builder = Reportify::Builder.new(@rep_objects, @rep_columns)

    @builder.stubs(:report_summary)
    @rep_objects.stubs(:each)
    @rep_formatter.stubs(:parse)
  end

  describe 'build' do

    it 'should cycle through the report objects' do
      @rep_objects.expects(:each).returns([])

      @builder.build(@rep_formatter)
    end

    it 'should cyle through the report columns' do
      @rep_objects.stubs(:each).yields(@rep_objects)
      @rep_columns.expects(:map)

      @builder.build(@rep_formatter)
    end

    it 'should build a report cell from the report column and report object' do
      @rep_objects.stubs(:each).yields(@rep_objects)
      @rep_columns.stubs(:map).yields(@rep_columns)
      @builder.expects(:build_cell)

      @builder.build(@rep_formatter)
    end

    it 'should handle the report summary' do
      @builder.expects(:report_summary)

      @builder.build(@rep_formatter)
    end

    it 'should parse the rows created' do
      @rep_formatter.expects(:parse).with(anything, @builder)

      @builder.build(@rep_formatter)
    end

  end

  describe 'headings' do

    before (:each) do
      @builder.stubs(:has_row_summary?)
      @sample_headings = ['first', 'second']
    end

    it 'should derive the headings from the report columns' do
      @builder.report_columns.expects(:map)
      @builder.headings
    end

    it 'should add the total heading if a row_summary is requested' do
      @builder.report_columns.expects(:map).returns(@sample_headings)
      @builder.expects(:has_row_summary?).returns(true)
      @sample_headings.expects(:push).with('Total')
      @builder.headings
    end

    it 'should not add the total heading when not needed' do
      @builder.report_columns.expects(:map).returns(@sample_headings)
      @builder.expects(:has_row_summary?).returns(false)
      @sample_headings.expects(:push).never
      @builder.headings
    end

  end

  describe 'has_column_summar?' do

    it 'should check all the report columns own has_column_summary method' do
      @rep_column = mock('mock rep column')
      @builder.report_columns.expects(:any?).yields(@rep_column)
      @rep_column.expects(:has_column_summary?)

      @builder.has_column_summary?
    end

  end

  describe 'has_row_summary?' do

    it 'should check all the report columns own has_row_summary method' do
      @rep_column = mock('mock rep column')
      @builder.report_columns.expects(:any?).yields(@rep_column)
      @rep_column.expects(:has_row_summary?)

      @builder.has_row_summary?
    end

  end


end
