
class CreateIntegralRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :rules do |t|
      t.string :rule_type
      t.decimal :score, precision: 12, scale: 2, default: 0.0, null: false
      t.text :description

      t.timestamps null: false
    end

    create_table :integral_records do |t|
      t.integer :post_id, index: true
      t.integer :user_id, index: true
      t.integer :rule_id, index: true
      t.decimal :score, precision: 12, scale: 2, default: 0.0, null: false
      t.decimal :radix_score, precision: 12, scale: 2, default: 0.0, null: false

      t.timestamps null: false
    end

    create_table :levels do |t|
      t.string :title
      t.integer :from_score
      t.integer :to_score
      t.string :icon
      t.decimal :radix, precision: 12, scale: 2, null: false, default: 0.0

      t.timestamps null: false
    end

    create_table :user_levels do |t|
      t.integer :user_id, index: true
      t.integer :level_id, index: true

      t.timestamps null: false
    end
  end
end
