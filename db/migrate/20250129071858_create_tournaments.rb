class CreateTournaments < ActiveRecord::Migration[7.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.datetime :date
      t.integer :max_participants
      t.string :status

      t.timestamps
    end
  end
end
