# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'xlsx_renderer/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'xlsx_renderer'
  spec.version     = XlsxRenderer::VERSION
  spec.authors     = ['KOBAYASHI-Toshinobu']
  spec.email       = ['toshinobu_kobayashi@tbn.co.jp']
  spec.homepage    = 'https://www.tbn.co.jp'
  spec.summary     = 'Excel Renderer with rubyXL.'
  spec.description = ''
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 5.2.3'

  # Excel parser/writer
  spec.add_dependency 'rubyXL'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
end
