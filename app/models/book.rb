class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, inverse_of: :book

  validates :name, presence: true, length: { maximum: 255 }

  validate  :not_repeated_by_user

  def to_s
    name
  end

  #protected

  def not_repeated_by_user
    return if Book.find_by(name:self.name,user:self.user).nil?
    
    errors.add  :name,  :invalid
  end

end
