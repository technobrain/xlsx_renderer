# frozen_string_literal: true
require 'rails/generators'

module XlsxRenderer
  module Generators
    class InitializerGenerator < Rails::Generators::Base
      desc "このジェネレータはconfig/initializersにuk_style.rbファイルを作成します"
      source_root File.expand_path('templates/config/initializers', __dir__)

      def copy_initializer_file
        dest = Rails.root.join('config', 'initializers', 'xlsx_renderer.rb')        
        copy_file 'xlsx_renderer.rb', dest
      end
    end
  end
end

