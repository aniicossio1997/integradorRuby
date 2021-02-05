class Note < ApplicationRecord
  belongs_to :book, optional: true ,inverse_of: :notes
  belongs_to :user, inverse_of: :notes
  validates :title, presence: true, length: { maximum: 255 }
  #validate  :not_repeated_by_user
  validates_uniqueness_of :title, scope: :book_id

  def to_s
    title
  end

  def not_repeated_by_user
    return if Note.find_by(title:self.title,user:self.user).nil?
    
    errors.add  :title,  :invalid
  end
end
