class Book
  attr_accessor :title
  attr_accessor :author
end

class Author
  attr_accessor :name
  attr_accessor :twitter
end

module BookPresenter
  include Mask::Presenter
  property :title
  property :author
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
