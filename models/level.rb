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

  private
    
end
