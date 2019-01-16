class AddIntegralToUserStats < ActiveRecord::Migration[5.2]
  def change
    add_column :user_stats, :integral, :decimal, default: 0.0, null: false, precision: 12, scale: 2
  end
end
