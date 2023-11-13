class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :profile, null: false, foreign_key: true
      t.text :content
      t.references :parent_tweet, foreign_key: { to_table: :tweets }

      t.timestamps
    end
  end
end
