require 'rouge'
require 'rouge/plugins/redcarpet'

class RougeHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
