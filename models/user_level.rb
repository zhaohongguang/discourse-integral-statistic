class UserLevel < ActiveRecord::Base
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :level, class_name: "Level", foreign_key: "level_id"
  
  class << self
    # 修改用户等级
    def update_user_level(user_id, level_id)
      user = User.includes(user_level: :level).where(id: user_id).last
      return if user.blank? || level_id.blank?      
      return if user.try(:level).try(:id) == level_id

      user_level = user.try(:user_level) || UserLevel.new(user_id: user_id)
      user_level.level_id = level_id

      user_level.save
    end
  end

  private
    
end
