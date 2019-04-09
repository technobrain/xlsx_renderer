# frozen_string_literal

module XlsxRenderer

  class << self

    def generate_xlsx(template, view_context)
      @view_context = view_context
      workbook = RubyXL::Parser.parse(Rails.root.join('app', 'views', 'xlsxs', template))
      
      workbook.worksheets.each do |sheet|
        sheet.each do |row|
          row&.cells&.each do |cell|
            next unless cell

            update_cell(sheet, cell)
          end
        end
      end

      workbook.stream.string
    end

    private

    def update_cell(sheet, cell)
      if /(?<records>@[\w]+)\.(?<attribute>[\w]+)/ =~ cell.value
        update_rows(sheet, cell, records, attribute)
      else
        cell.change_contents(content_eval(%("#{cell.value}")))
      end
    end

    def update_rows(sheet, cell, records, attribute)
      column = cell.column
      @view_context.instance_eval(records).each_with_index do |_record, idx|
        row = cell.row + idx
        value = content_eval(records)[idx][attribute]
        p [value, attribute, idx]
        sheet.add_cell(row, column, value)
      end
    end

    def content_eval(value)
      @view_context.instance_eval(value)
    end
  end
end