
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

    rules = [{rule_type: 'topic', score: 1, description: '发布主题奖励1积分'}, {rule_type: 'top_five_post', score: 3, description: '发布主题奖励3基础积分'}, {rule_type: 'not_top_five_post', score: 1, description: '发布主题奖励1基础积分'}, {rule_type: 'like', score: 0.2, description: '点赞获取0.2的基础积分'}, {rule_type: 'abuse_vilify', score: -500, description: '辱骂、诽谤他人'}, {rule_type: 'politics_religion', score: -1000, description: '发布政治、宗教等不当言论'}]
    rules.each do |rule|
      execute "INSERT INTO rules (rule_type, score, description, created_at, updated_at)
               VALUES ('#{rule[:rule_type]}', #{rule[:score]}, '#{rule[:description]}', '#{Time.now}', '#{Time.now}');"
    end

    levels = [{ title: 'darksteel', from_score: 0, to_score: 9, radix: 0.5},{ title: 'bronze', from_score: 10, to_score: 99, radix: 0.6},{ title: 'silver', from_score: 100, to_score: 299, radix: 0.7},{ title: 'gold', from_score: 300, to_score: 699, radix: 0.8},{ title: 'platinum', from_score: 700, to_score: 1999, radix: 1},{ title: 'diamond', from_score: 2000, to_score: 1000000, radix: 0.5}]
    levels.each do |level|
      execute "INSERT INTO levels (title, from_score, to_score, radix, created_at, updated_at)
               VALUES ('#{level[:title]}', #{level[:from_score]}, #{level[:to_score]}, #{level[:radix]}, '#{Time.now}', '#{Time.now}');"
    end
  end
end
