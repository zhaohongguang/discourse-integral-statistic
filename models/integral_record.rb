class IntegralRecord < ActiveRecord::Base

  belongs_to :post, class_name: "Post", foreign_key: "post_id", optional: true
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :rule, class_name: "Rule", foreign_key: "rule_id"
  
  class << self
    # 创建积分记录
    def create_integral_record(options)
      # 根据用户回复规则判断该积分记录是否重复增加
      integral_records = IntegralRecord.where(post_id: options[:post_id], user_id: options[:user_id], rule_id: options[:rule_id])
      return if integral_records.present?
      integral_record = IntegralRecord.new

      integral_record.post_id = options[:post_id]
      integral_record.user_id = options[:user_id]
      integral_record.rule_id = options[:rule_id]
      integral_record.score = options[:score]
      integral_record.radix_score = options[:radix_score]

      integral_record.save

      # 更新user_stat积分数据
      user_stat = UserStat.where(user_id: options[:user_id]).last
      user_stat.update_columns(integral: user_stat.integral + options[:score])
    end
  end

  private
    
end
