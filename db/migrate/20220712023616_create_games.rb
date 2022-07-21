class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :word_to_guess
      t.integer :lives
      t.string :hidden_word
      t.string :user_letter

      t.timestamps
    end
  end

  # def self.up self.down
end
