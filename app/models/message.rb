class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :body, presence: true

  before_validation :assign_number, on: :create
  after_commit :index_message_to_elasticsearch, on: :create

  private

  def assign_number
    self.number = (Message.where(chat_id: chat_id).maximum(:number) || 0) + 1
  end

  def index_message_to_elasticsearch
    ElasticSearchWorker.perform_async(id)
  end
end
