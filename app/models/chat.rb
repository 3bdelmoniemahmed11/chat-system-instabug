class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy
  validates :number, presence: true, uniqueness: { scope: :application_id }

  before_validation :assign_number, on: :create

  private

  def assign_number
    self.number = (Chat.where(application_id: application_id).maximum(:number) || 0) + 1
  end
end
