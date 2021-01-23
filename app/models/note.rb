class Note < ApplicationRecord
  belongs_to :book, inverse_of: :notes
  belongs_to :user, inverse_of: :notes
  validates :title, presence: true, length: { maximum: 255 }

  def to_s
    title
  end

  def not_repeated_by_user
    return if Note.find_by(book:self.book,user:Book.first.user).nil?
    
    errors.add  :name,  :invalid
  end

end
