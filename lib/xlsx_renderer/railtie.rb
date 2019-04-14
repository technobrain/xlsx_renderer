# frozen_string_literal: true

require 'xlsx_renderer/config'
require 'xlsx_renderer/generators/initializer_generator'

module XlsxRenderer
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config) if block_given?
  end

  class Railtie < ::Rails::Railtie
    # Dir.glob("#{__dir__}/../tasks/**/*.rake").each { |file| load file }

    initializer 'xlsx_renderer' do
      require 'rubyXL'
      require 'rubyXL/convenience_methods/cell'
      Mime::Type.register 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx

      require 'xlsx_renderer/renderer'
    end
  end
end
