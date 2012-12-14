# Reportify

Reportify is used to convert ruby result sets into reports quickly.

High Level Features:
* Format the results using one of the given format options
* Export to excel helpers

## Installation

Add this line to your application's Gemfile:

    gem 'reportify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reportify

## Usage ( Quick Start )

First you need to define the columns for your report / csv download

```
report_cols = []
report_cols.push Reportify::ReportColumn.new( {:method_name=>'driver_fullname', :summarize=>'none'} )
report_cols.push Reportify::ReportColumn.new( {:method_name=>'make', :summarize=>'none'} )
report_cols.push Reportify::ReportColumn.new( {:method_name=>'races_won', :summarize=>'both'} )
```

Once you have the columns you'll need to create a report builder.

Pass in the objects you are basing your report from.  For example:
```
@drivers = Driver.all
@report = Reportify::Builder.new(@drivers, report_cols)
```

Now you can build the report in the format that you need.
In this example you want the data built as an html_table for a view.

( In your controller )
`report_rows = @report.build(Reportify::ReportFormat.create('html_table'))`

Here's a partial you can use to get started on html_reports

```
<table class="no-style full tree" id="open_order_report">
  <thead>
    <tr>
      <% reportify.headings.each do |field| %>
        <th><%= field %></th>
      <% end %>
    </tr>
  </thead>
  <tbody>
  <% reportify.build(reportify::ReportFormat.create('html_table')).each do |row| %>
      <tr>
        <% row.each do |col| %>
          <td><%= col.formatted_value %></td>
        <% end %>
      </tr>
      <% end %>
  </tbody>
</table>
```

If you wanted to maybe export this report to a csv you would:

```
send_data(@report.build(ReportBuilder::ReportFormat.create('ruby_csv')),
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=race_stats.csv")
```

## Report Column Options:

When creating report columns there are a few options you can give:

Required:
  method_name - This is the name of the method in the given set of objects you want to display.
    Example when reporting on Objects:  
      if you had: User(:name=>'Joe')
      `ReportColumn.new( {:method_name=>'name'} )`  
      Note: If you are using an Array of hashes instead of objects the above also works.
      if the User has an associated Address you can do:
      `ReportColumn.new( {:method_name=>'user.address'} )`
      
  display_name - This is the name you want to appear as a heading for your report or export.
                 This is an optional param.  If skipped reportify runs titleize on the method_name.
  
  summarize -  If you need to summarize some numbers that are in your report you can use this option.
               
               Example: 'column' summary used for all columns
               A | B | C      
               1 | 2 | 3      
               2 | 3 | 4      
               2 | 5 | 7                       
               
               Example: B has a column summary, A and B have row summary selected
               A | B | C | Total
               1 | 2 | 3 | 6
               2 | 3 | 4 | 9
                 | 5 |   |
                 
              Note:
              If you mix both row and column summaries you won't get the grand total value in the bottom right corner
              because it wouldn't really make sense.  You will get that grand total if you are consistent and use 
              all 'row' or all 'column' based summaries.
               
              This is optional and defaults to 'none' when not given.
              Valid options are 'row', 'column', 'both', 'none'

## Formatters 

  When you create a report column it will be treated as a string value by default, but sometimes you
  may want to format your values differently.
    
  If you want to format values for a column as a whole number for instance you would do this:
  `ReportBuilder::ColumnFormat.create('whole_number')`
  
  So your report column code would be:
  whole_number_formatter = ReportBuilder::ColumnFormat.create('whole_number')
  `ReportColumn.new({:method_name=>'weight', :formatter=>whole_number_formatter})`
  
  Other available formatters:
  percent      - 98 -> %98.00
  week_of_year - Give date -> number from 1-52 
  whole_number - 10.44 -> 10
  
  # TODO - examples of formatters with options used
  
  You can add a customer formatter to the source pretty easily if the built-ins don't provide what you need.
  Create a class in /lib/reportify/column_formatters and implemnt a format method with the signature:
  
  ```
  def format(value, options={})
  end
  ```

## Export MIME Type

  Instead of exporting the data like this:
  
  ```
  send_data(@report.build(ReportBuilder::ReportFormat.create('ruby_csv')),
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=race_stats.csv")
  ```        
 
  You might want to do this:
  ```
  respond_to do |format| 
    format.html 
    format.csv_reportify  { render :csv_reportify => @report, :file_name=>"racecar.csv" }
  end
  ```

 First  add / Edit your /config/initializers/mime_types.rb to include

 `Mime::Type.register_alias "text/csv", :csv_reportify`

 Then add the csv_repority.rb class in initializers:
 ```
 require "action_controller"

  ActionController::add_renderer :csv_reportify do |report, options| 
    name = options[:file_name] || "csv_reportify"
    send_data(report.build(Reportify::ReportFormat.create('ruby_csv')),
      :type => Mime::CSV_REPORTIFY, :disposition => "attachment; filename=#{name}.csv")
 end 
``` 

I ran into a quirk in IE with this one using the html form's standard submit.  If you have the same problem
Do something like this:

```
 # Put a hidden field in your form:
 <%= hidden_field_tag 'format', 'html' %>

 # Then have the csv submit call a function instead:
 <%= link_to_function 'Download as CSV', "submit_as_csv_reportify();" %>
 
 function submit_as_csv_reportify() {
    $("#my_form #format").val("csv_reportify");
    $('#my_form').submit();
    $("#my_form #format").val("html");
    return false;
  }

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
