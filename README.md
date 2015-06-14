[![Build Status](https://travis-ci.org/allenwei/mask.svg)](https://travis-ci.org/allenwei/mask)
[![Code Climate](https://codeclimate.com/github/allenwei/mask/badges/gpa.svg)](https://codeclimate.com/github/allenwei/mask)

# Mask

`Mask` is a protocol of micro service APIs.

Beside object serializer, `mask` also provider a way generate ruby objects from hash.

So we can share the object-oriented API between services.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mask'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mask

## Usage



### Serialize ruby object to hash


```ruby
class Book
  attr_accessor :title
  attr_accessor :author
end


module BookPresenter
  include Mask::Presenter
  property :title
  property :author
end

```

```ruby
book = Book.new
book.title = "The Well-Grounded Rubyist"
book.author = "David A. Black"
book.extend(BookPresenter)
book.to_hash #=> {"title": "The Well-Grounded Rubyist", "author": "David A. Black" }
```

### Serialize same ruby object with different presenter

```ruby
module SimpleBookPresenter
  include Mask::Presenter
  property :title
end

book.extend(SimpleBookPresenter)
book.to_hash #=> {"title": "The Well-Grounded Rubyist" }

```

### Generate ruby object from hash

```ruby
book_data = {"title": "The Well-Grounded Rubyist", "author": "David A. Black" }
book = Book.new
book.extend(BookPresenter)
book.from_hash(book_data)
book.title #=> "The Well-Grounded Rubyist"
book.author #=> "David A. Black"
```


### Associated objects

```ruby
class Author
  attr_accessor :name
  attr_accessor :twitter
end


module AuthorPresenter
  include Mask::Presenter
  property :name
  property :twitter
end

module BookWithAuthorPresenter
  include Mask::Presenter
  property :title
  property :author, presenter: AuthorPresenter, klass: Author
end

```

```ruby
book = Book.new
book.title = "The Well-Grounded Rubyist"
author = Author.new
author.name = "David A. Black"
author.twitter = "@david_a_black"
book.author = author
book.extend(BookWithAuthorPresenter)
book.to_hash #=> {"title": "The Well-Grounded Rubyist", "author": {"name": "David A. Black", "twitter": "@david_a_black" }}

```

### Generate object from nested hash

```ruby
 book_data = {"title": "The Well-Grounded Rubyist", "author": {"name": "David A. Black", "twitter": "@david_a_black" }}
 book = Book.new
 book.extend(BookWithAuthorPresenter)
 book.from_hash(book_data)
 book.title #=> "The Well-Grounded Rubyist"
 book.author.name #=> "David A. Black"
 book.author.twitter #=> "@david_a_black"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mask/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
