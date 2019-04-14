# XlsxRenderer
Short description and motivation.

## Usage

### Controller

User format type 'xlsx'.
And `send_data XlsxRenderer.generate_xlsx('template.xlsx', view_context), filename: 'report.xlsx'`
in respond_to block.

Example

```ruby
# GET /todos
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html { render action: :index }
      format.xlsx do
        json = @todos.as_json
        @report = { title: 'Report title', issue_date: Time.zone.today }
        @data = json.map do |record|
          record.tap do |rec|
            rec['due_date'] = rec['due_date'].strftime('%Y/%m/%d')
            rec['completed_at'] = rec['completed_at']&.localtime&.strftime('%Y/%m/%d %H:%M')
            rec['created_at'] = rec['created_at'].strftime('%Y/%m/%d %H:%M')
            rec['updated_at'] = rec['updated_at'].strftime('%Y/%m/%d %H:%M')
          end
        end

        template = 'todo_list.xlsx'
        send_data XlsxRenderer.generate_xlsx(template, view_context),
                  filename: "export_#{Time.zone.today}.xlsx"
      end
    end
  end
end
```

### Template(Excel file)

Write interpolation like `#{value[:key]}` into cell.

You want to use list `#{@records[].attribute}`.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'xlsx_renderer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install xlsx_renderer
```

Optionaly, you can run the generator, which create initializer file.

```bash
$ rails g xlsx_renderer:initializer
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
