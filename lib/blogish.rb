require "redcarpet"
require "blogish/version"
require "blogish/rouge_html"

module Blogish
  extend self

  def fetch(slug)
    path = entries.detect { |file| file =~ /_#{Regexp.quote(slug)}.mkd$/ }
    path ? open(path) : nil
  end

  def fetch_all
    entries.sort.reverse.map { |entry| open(entry) }
  end

  private

  def entries
    Dir.chdir("views/blog") { glob("*.mkd") }
  end

  def open(path)
    date, slug = path.chomp('.mkd').split('_', 2)
    title, body = File.read(path).split(/^---+$/, 2)
    date = Date.parse(date)
    title.strip!
    body = convert_to_html(body).strip
    intro = convert_to_html(body.lines.map.first).strip
    {date: date, title: title, slug: slug, body: body, intro: intro}
  end

  def convert_to_html(markdown)
    renderer = RougeHTML
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render markdown
  end

end