class IntegralRecord < ActiveRecord::Base

  belongs_to :post, class_name: "Post", foreign_key: "post_id", optional: true
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :rule, class_name: "Rule", foreign_key: "rule_id"
  
  class << self
    # 创建积分记录
    def create_integral_record(options)
      # 根据用户回复规则判断该积分记录是否重复增加
      integral_records = IntegralRecord.where(user_id: options[:user_id], rule_id: options[:rule_id])
      if options[:post_id].present? && integral_records.present?
        integral_records = integral_records.where(post_id: options[:post_id])
        return if integral_records.present?
      end
      integral_record = IntegralRecord.new

      integral_record.post_id = options[:post_id] if options[:post_id].present?
      integral_record.user_id = options[:user_id]
      integral_record.rule_id = options[:rule_id]
      integral_record.score = options[:score]
      integral_record.radix_score = options[:radix_score] || 1
      integral_record.note = options[:note] if options[:note].present?

      integral_record.save

      # 更新user_stat积分数据
      user_stat = UserStat.where(user_id: options[:user_id]).last
      user_stat.update_columns(integral: user_stat.integral + options[:score])

      level = Level.level_from_integral(user_stat.integral.to_f)
      UserLevel.update_user_level(options[:user_id], level.try(:id))
    end
  end

  private
    
end
