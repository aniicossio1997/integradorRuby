class Book < ApplicationRecord
  belongs_to :user, inverse_of: :books
  has_many :notes, dependent: :delete_all, inverse_of: :book
  before_validation :sanitizer_name

  validates_associated :notes

  validates :name, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :name, scope: :user_id

  scope :books_user_logged, ->(current_user) {where(user:current_user)}
  validate :check_name
  def to_s
    self.name
  end
  def sanitizer_name
    self.name = self.name.strip
  end

  def check_name
    return if !((self.name).downcase=="global")

    errors.add(:base, I18n.t(:error_name_global))
    throw(:abort)
  end

end
