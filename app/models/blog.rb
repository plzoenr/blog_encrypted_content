class Blog < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :slug, presence: true, uniqueness: true
  validates_presence_of :author, :slug, :content

  encrypts :content # Enables Rails encryption

  def to_param
    slug
  end

  def content_base64
    Base64.encode64(content)
  end

  private

  def generate_slug
    self.slug ||= build_slug
  end

  def build_slug
    "#{find_tree_first_word}-#{SecureRandom.hex}"
  end

  def find_tree_first_word
    self.content.split(" ")[0..2].join("-").downcase
  end
end
