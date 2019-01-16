class UserLevel < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :level, class_name: "Level", foreign_key: "level_id"
  

  private
    
end
