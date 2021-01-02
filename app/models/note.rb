class Note < ApplicationRecord
  belongs_to :book, inverse_of: :notes

  validates :title, presence: true, length: { maximum: 255 }

  def to_s
    title
  end
end
