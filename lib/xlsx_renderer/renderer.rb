# frozen_string_literal

module XlsxRenderer
  class << self
    def generate_xlsx(template, view_context)
      @view_context = view_context
      workbook = RubyXL::Parser.parse(Rails.root.join('app', 'views', 'xlsxs', template))
      
      workbook.worksheets.each do |sheet|
        sheet.each do |row|
          row&.cells&.each do |cell|
            next if cell&.value.blank?

            update_cell(sheet, cell)
          end
        end
      end

      workbook.stream.string
    end

    private

    def update_cell(sheet, cell)
      if /(?<records>@[\w]+)\[\]\.(?<attribute>[\w]+)/ =~ cell.value
        insert_rows_with_original_style(sheet, cell, records, attribute)
      else
        cell.change_contents(content_eval(%("#{cell.value}")))
      end
    end

    def insert_rows_with_original_style(sheet, cell, records, attribute)
      insert_rows(sheet, cell, records, attribute) do |new_cell|
        original_style_index = cell.style_index
        new_cell.style_index = original_style_index
      end
    end

    def insert_rows(sheet, cell, records, attribute)
      column = cell.column
      @view_context.instance_eval(records).each_with_index do |_record, idx|
        row = cell.row + idx
        value = content_eval(records)[idx][attribute]
        sheet.add_cell(row, column, value)
        yield(sheet[row][column]) if block_given?
      end
    end

    def content_eval(value)
      @view_context.instance_eval(value)
    end
  end
end