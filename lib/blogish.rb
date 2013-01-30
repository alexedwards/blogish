require 'redcarpet'
require "blogish/version"
require "blogish/rouge_html"

module Blogish
  extend self

  def fetch_all
    entries.sort.reverse.map { |entry| open(entry) }
  end

  def fetch(slug)
    path = entries.detect { |file| file =~ /_#{Regexp.quote(slug)}.mkd$/ }
    path ? open(path) : nil
  end

  private

  def open(path)
    path = Pathname.new(path)
    title, body = path.read.split(/^---+$/, 2)
    date, slug = path.basename.to_s.chomp(path.extname).split('_', 2)
    date = Date.parse(date)
    body = convert_to_html(body.lstrip)
    intro = convert_to_html(body.lines.map.first)
    {date: date, title: title, slug: slug, body: body, intro: intro}
  end

  def entries
    Dir.glob("views/blog/*.mkd")
  end

  def convert_to_html(mkd)
    renderer = RougeHTML
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render mkd
  end

end
