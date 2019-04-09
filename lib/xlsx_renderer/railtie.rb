module XlsxRenderer
  class Railtie < ::Rails::Railtie
    initializer 'xlsx_renderer' do
      require 'rubyXL'
      require 'rubyXL/convenience_methods/cell'
      Mime::Type.register 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx

      require 'xlsx_renderer/renderer'
    end
  end
end
