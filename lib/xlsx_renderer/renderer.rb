# frozen_string_literal

module XlsxRenderer
  def self.generate_xlsx(template)
    workbook = RubyXL::Parser.parse(Rails.root.join('app', 'views', 'xlsxs', template))
    workbook.stream.string
  end
end