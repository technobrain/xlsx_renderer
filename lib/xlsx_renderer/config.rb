# frozen_string_literal: true

module XlsxRenderer
  class Config
    attr_accessor :xlsx_template_path

    def initialize
      @xlsx_template_path = Rails.root.join('app', 'views', 'xlsxs')
    end
  end
end
