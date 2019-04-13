# frozen_string_literal: true

require 'test_helper'

module XlsxRenderer
  module Generators
    class InitializerGeneratorTest < Rails::Generators::TestCase
      tests XlsxRenderer::Generators::InitializerGenerator
      destination File.expand_path(Rails.root)

      setup do
        FileUtils.remove_file initializer_file, force: true
      end

      def initializer_file
        @initializer_file ||= Rails.root.join('config', 'initializers', 'xlsx_renderer.rb')
      end

      test 'create an initializer file' do
        run_generator
        assert_file initializer_file
      end
    end
  end
end

