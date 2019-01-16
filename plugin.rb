# name: DiscourseIntegralStatistic
# about:
# version: 0.1
# authors: zhaohongguang
# url: https://github.com/zhaohongguang


register_asset "stylesheets/common/discourse-integral-statistic.scss"

load File.expand_path("../models/integral_record.rb", __FILE__)
load File.expand_path("../models/level.rb", __FILE__)
load File.expand_path("../models/rule.rb", __FILE__)
load File.expand_path("../models/user_level.rb", __FILE__)

enabled_site_setting :discourse_integral_statistic_enabled

PLUGIN_NAME ||= "DiscourseIntegralStatistic".freeze

after_initialize do
  
  # see lib/plugin/instance.rb for the methods available in this context
  require_dependency 'application_controller'
  module ::DiscourseIntegralStatistic
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseIntegralStatistic
    end
  end



  # 用户
  require_dependency 'user'
  class ::User
    has_one :user_level, class_name: "UserLevel", dependent: :destroy
    has_one :level, through: :user_level

    has_many :integral_records, class_name: "IntegralRecord", dependent: :destroy
  end

  # 发布帖子或者回复帖子获取积分
  require_dependency 'post'
  class ::Post

    after_create :statistic_integral

    # IntegralRecord.create_integral_record(options)
    # 回调方法统计积分
    def statistic_integral
      user = User.where(id: self.user_id).last
      level = user.try(:level)
      user_stat = user.user_stat
      return if user.blank? || level.blank? || user_stat.blank?

      radix = level.radix  # 根据等级获取积分比例
      integral_type = self.comfirm_integral_type # 积分获取类型
      return if integral_type.blank?

      parameter = self.generate_parameter(radix, integral_type) || { }
      return if parameter.blank? 

      Post.transaction do
        # 开始创建积分记录
        IntegralRecord.create_integral_record(parameter)
      end

    end

    # 判断是否为帖子
    def is_post?
      self.post_number.to_i == 1
    end

    # 判断是否为主回复
    def is_reply?
      self.reply_to_post_number.blank? && !self.is_post?
    end

    # 是否为自问自答(true 为自问自答)
    def oneself_reply?
      self.try(:topic).try(:user_id).to_i == self.user_id
    end

    # 确定获取积分类型
    def comfirm_integral_type
      integral_type = ''   # 积分类型
      
      if self.is_reply?
        integral_type = Rule::RuleType::TOPIC
      end

      # 判断是否为正常的回复(非自问自答的主回复)
      if self.is_reply? && !self.oneself_reply?
        # 判断是都是为前五条回复
        # TODO 需要写成sql语句进行快速查询
        if self.topic.posts.where(reply_to_post_number: nil).where.not(post_number: 1).order(created_at: :asc).limit(5).include?(self)
          integral_type = Rule::RuleType::TOP_FIVE_POST
        else
          integral_type = Rule::RuleType::NOT_TOP_FIVE_POST
        end
      end

      integral_type
    end

    # 构造创建积分记录参数
    def generate_parameter(radix_score, integral_type)
      rule = Rule.where(rule_type: integral_type).last
      return if rule.blank?

      score = integral_type == Rule::RuleType::TOPIC ? rule.score : rule.score*radix_score
      
      parameter = {
                    post_id: self.id,
                    user_id: self.user_id,
                    rule_id: rule.id,
                    score: score,
                    radix_score: radix_score,
                  }

      parameter
    end

  end

  require_dependency 'post_action'
  class ::PostAction
    after_save :update_integral, if: :is_like_type?

    def update_integral
      post = self.post
      user = post.try(:user)
      user = post.try(:user)
      level = user.try(:level)
      return if post.blank? || user.blank? || level.blank?

      parameter = post.generate_parameter(level.radix, 'like')
      PostAction.transaction do
        IntegralRecord.create_integral_record(parameter)
      end
    end

    # 判断为是点赞还是取消点赞(点赞为true  取消点赞为false)
    def is_like?
      self.deleted_at.blank? && deleted_by_id.blank?
    end

    # 判断是否为点赞类型
    def is_like_type?
      self.post_action_type.try(:name_key) == 'like'
    end
  end

  require_dependency 'user_summary'
  class ::UserSummary
    delegate :integral, to: :user_stat
  end

  require_dependency 'user_summary_serializer'
  class ::UserSummarySerializer
    attributes :integral
  end

  require_dependency 'admin_user_list_serializer'
  class ::AdminUserListSerializer
    [:integral].each do |sym|
      attributes sym
      define_method sym do
        object.user_stat.send(sym)
      end
    end
  end

  load File.expand_path("../controllers/admin.rb", __FILE__)
  load File.expand_path("../controllers/integral_records.rb", __FILE__)
  load File.expand_path("../serializers/integral_records_serializers.rb", __FILE__)
  
  # require_dependency 'admin_constraint'
  Discourse::Application.routes.prepend do
    get "admin/integral-records" => "admin#index"
    get "admin/user/integral_records" => "integral_records#index"
  end

  

  
  require_dependency "application_controller"
  class DiscourseIntegralStatistic::ActionsController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    before_action :ensure_logged_in

    def list
      render json: success_json
    end
  end

  DiscourseIntegralStatistic::Engine.routes.draw do
    get "/list" => "actions#list"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseIntegralStatistic::Engine, at: "/discourse-integral-statistic"
  end
  
end
