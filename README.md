# Blogish

Blogish is a tiny and powerful blogging engine, wrapped up in a Rubygem. It supports markdown-based entries, RSS feeds and syntax highlighting.

It aims to provide the functions you need to create and display entries, but without dictating site layout or design. That makes it well suited for situations where you want to incorporate a simple blog into an pre-existing site.

## Installation

Add this line to your application's Gemfile:

    gem 'blogish'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blogish

## Usage

```
require 'blogish'
```

### Creating new posts

Blogish reads entries stored in flat [markdown](http://daringfireball.net/projects/markdown/) files in a `views/blog` directory.

It relies on certain conventions to work. Each entry should be named using the date of the entry and the URL slug, separated by an underscore and with the `.mkd` extension.

```
<date>_<slug>.mkd
```

The first line of the each entry should contain its title, then three dashes to separate it from the main body of the entry. Putting it all together:

```
$ cat views/blog/2013-02-07_hello-world.mkd
Hello World!
---
This is the first paragraph.

This is the second paragraph. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Hic porro quae ea amet 
dolores quibusdam magni illum harum unde tempore nisi totam adipisci quisquam aliquid quis ab necessitatibus? 
Mollitia explicabo aperiam asperiores doloremque officiis ipsam. Animi distinctio a dolor consequuntur.
```

### Displaying a post

You can display a single post based on it's slug using the `fetch` method. For example:

```
Blogish.fetch('hello-world')
```

If a matching entry is found, then a Hash with the contents of the post is returned. This Hash can then be passed to your view file, or wherever else you need to use the information.

```
{
  :title => 'Hello World',
  :date => #<Date: 2013-02-07 ((2456088j,0s,0n),+0s,2299161j)>,
  :slug => 'hello-world',
  :intro => '<p>This is the first paragraph</p>',
  :body => '<p>This is the first paragraph</p><p>This is the second paragraph. Lorem ipsum ...</p>'
}
```

If no entry with a matching slug is found, the method returns `nil`. 

### Displaying multiple posts

You can also display all entries using the `fetch_all` method. This returns an Array of all entries in the directory, sorted with the most recently dated first.

```
Blogish.fetch_all
```

This Array can then be passed to your view file, or wherever else you need to use it.

### Using Syntax Highlighting

Syntax highlighting is supported out of the box thanks to [Rouge](https://github.com/jayferd/rouge). A list of supported languages is [here](http://rouge.jayferd.us/demo). Simply wrap any code in your markdown files in fenced blocks, github style.

```text
&#96;&#96;&#96;ruby
# This is my code
@foo = bar
&#96;&#96;&#96;
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
