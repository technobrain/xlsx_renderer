# frozen_string_literal: true

XlsxRenderer.configure do |config|
  config.xlsx_template_path = Rails.root.join('app', 'views', 'xlsxs')
end
