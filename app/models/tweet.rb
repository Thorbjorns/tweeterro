class Tweet < ApplicationRecord
  validates :content, { presence: true, message: 'Content is required' }
  validates :content, { minimum: 2, maximum: 255, message: 'Content must be at least 2 characters and cannot have more than 255 characters' }

  belongs_to :profile
  belongs_to :parent_tweet, class_name: 'Tweet', optional: true
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_tweet_id', dependent: :destroy
  belongs_to :group, optional: true

  accepts_nested_attributes_for :replies

end
