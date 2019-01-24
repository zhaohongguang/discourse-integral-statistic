class Level < ActiveRecord::Base
  has_many :user_levels, class_name: "UserLevel", foreign_key: "user_level_id", dependent: :destroy
  
  module Title
    DARKSTEEL = 'darksteel'
    BRONZE = 'bronze'
    SILVER = 'silver'
    GOLD = 'gold'
    PLATINUM = 'platinum'
    DIAMOND = 'diamond'
  end

  class << self
    # 根据分数判断等级
    def level_from_integral(integral)
      levels = Level.order(from_score: :asc)

      level = levels.first if integral.floor < levels.first.from_score
      level = levels.last if integral.floor > levels.last.to_score
      level ||= levels.where("from_score <= ? AND to_score >= ?", integral.floor, integral.floor).last

      return level
    end
  end

  private
    
end
