class AddCurrentRoundToTournaments < ActiveRecord::Migration[7.2]
  def change
    add_column :tournaments, :current_round, :integer, default: 1
  end
end
