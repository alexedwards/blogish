require "redcarpet"
require "blogish/version"
require "blogish/rouge_html"

module Blogish
  extend self

  # Fetch and parse a single blog entry based on its slug.
  #
  # * @params slug [String]
  # * @return [nil] if no matching slug is found
  # * @return [Hash] representing the blog entry if a matching slug is found.
  #
  # == Example:
  #
  # If we have a file named
  #     views/blog/2013-02-07_hello-world.mkd
  # then running
  #     Blogish.fetch('hello-world')
  # will find the file and return a hash containing the following keys:
  #
  # * :title [String]
  # * :date [Date]
  # * :slug [String]
  # * :intro [String]
  # * :body [String]

  def fetch(slug)
    path = entries.detect { |file| file =~ /_#{Regexp.quote(slug)}.mkd$/ }
    path ? open(path) : nil
  end

  # Fetch and parse all blog entries in the `views/blog` directory, sorted
  # by date with the most recent entry first.
  #
  # * @params none
  # * @return [Array] of hashes representing each blog entry.
  #
  # == Example:
  #
  # If we have files named
  #     views/blog/2013-02-07_hello-world.mkd
  # and
  #     views/blog/2013-02-05_foo-post.mkd
  # then running
  #     Blogish.fetch
  # will return an Array containing both entries:
  #     [{:title => 'Foo Post', ...}, {:title => 'Hello World', ...}]

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
