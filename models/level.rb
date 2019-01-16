class Level < ActiveRecord::Base
  has_many :user_levels, class_name: "UserLevel", foreign_key: "user_level_id", dependent: :destroy
  

  private
    
end
