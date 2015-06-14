require 'spec_helper'

describe Mask::Presenter do 

  describe "#to_hash" do
    context "for basic type" do
      it 'converts object to hash' do
        book = Book.new
        book.title = "The Well-Grounded Rubyist"
        book.author = "David A. Black"
        book.extend(BookPresenter)
        expect(book.to_hash).to eq({title: "The Well-Grounded Rubyist", author: "David A. Black" })
      end
    end

    context "with association" do
      it 'converts object to nested hash' do
        book = Book.new
        book.title = "The Well-Grounded Rubyist"
        author = Author.new
        author.name = "David A. Black"
        author.twitter = "@david_a_black"
        book.author = author
        book.extend(BookWithAuthorPresenter)
        expect(book.to_hash).to eq({title: "The Well-Grounded Rubyist", author: {name: "David A. Black", twitter: "@david_a_black" }})
      end
    end
  end

  describe "#from_hash" do
    it 'generate object from hash' do
      book_data = {title: "The Well-Grounded Rubyist", author: "David A. Black" }
      book = Book.new
      book.extend(BookPresenter)
      book.from_hash(book_data)
      expect(book.title).to eq "The Well-Grounded Rubyist"
      expect(book.author).to eq "David A. Black"
    end

    it 'generate assoication object from hash' do
      book_data = {title: "The Well-Grounded Rubyist", author: {name: "David A. Black", twitter: "@david_a_black" }}
      book = Book.new
      book.extend(BookWithAuthorPresenter)
      book.from_hash(book_data)
      expect(book.title).to eq "The Well-Grounded Rubyist"
      expect(book.author.name).to eq "David A. Black"
      expect(book.author.twitter).to eq "@david_a_black"
    end
  end
end
