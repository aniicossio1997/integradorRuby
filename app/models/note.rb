class Note < ApplicationRecord
  belongs_to :book, optional: true ,inverse_of: :notes
  belongs_to :user, inverse_of: :notes
  validates :title, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :title, scope: [:book_id, :user_id]

  #validates_uniqueness_of :column_name1, scope: [:column_name2, :column_name3]


  scope :without_book, -> { where(book:nil)}
  scope :only_book, ->(book) { where(book:book)}
  scope :sort_name, ->(sort) { order(title: sort) }
  scope :notes_user_logged, ->(current_user) {where(user:current_user)}
  scope :notes_global, ->(user) {where(book:nil, user:user)}
  #scope :notes_user_logged, ->(user){ where(user:user)}
  def to_s
    title
  end
  def name_book
    if self.book.nil?
      return "global"
    else
      self.book.name
    end

    
  end

  def title_for_download
    name_book=(self.book.nil? ? 'global' : self.book.name)
    name_book +"_"+ title
  end

  def markdown
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    (Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)).render("###### #{title}<br>\n #{markdown_content}")
  end

  def markdown_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render("#{content}")


  end



end
