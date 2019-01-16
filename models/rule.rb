class Rule < ActiveRecord::Base

  module RuleType
    TOPIC = 'topic'
    TOP_FIVE_POST = 'top_five_post'
    NOT_TOP_FIVE_POST = 'not_top_five_post'
  end

  private
    
end
