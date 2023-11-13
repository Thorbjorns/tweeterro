class Tweet < ApplicationRecord
  belongs_to :profile

  belongs_to :parent_tweet, class_name: 'Tweet', optional: true
  has_many :replies, class_name: 'Tweet', foreign_key: 'parent_tweet_id', dependent: :destroy
  belongs_to :group, optional: true

  accepts_nested_attributes_for :replies

end
