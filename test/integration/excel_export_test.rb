# frozen_string_literal: true

require 'test_helper'

class ExcelExportTest < ActionDispatch::IntegrationTest
  test 'export excel as file' do
    get todos_path(format: :xlsx)

    assert_equal 'binary', headers['Content-Transfer-Encoding']
  end
end
