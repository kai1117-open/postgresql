class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :player1, null: false, foreign_key: true
      t.references :player2, null: false, foreign_key: true
      t.integer :round
      t.string :result

      t.timestamps
    end
  end
end
