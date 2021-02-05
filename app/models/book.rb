class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :delete_all, inverse_of: :book

  validates_associated :notes

  validates :name, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :name, scope: :user_id
  scope :books_user_logged, ->(current_user) {where(user:current_user)}

  #validate  :not_repeated_by_user

  def to_s
    self.name
  end

  def self.books_user_concurent
    @books = user_signed_in? ? current_user.books : User.new.books
    books
  end


  #protected

  def not_repeated_by_user
    return if Book.find_by(name:self.name,user:self.user).nil?
    
    errors.add  :name,  :invalid
  end

end
