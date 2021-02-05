class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many  :books, inverse_of: :user
  has_many  :notes, inverse_of: :user
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_s
    email
  end
  def order_books
    self.books.order(:name)
  end
  def books_count
    self.books.count
  end
  def notes_count
    self.notes.count
  end
end
