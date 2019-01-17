class Rule < ActiveRecord::Base

  module RuleType
    TOPIC = 'topic'
    TOP_FIVE_POST = 'top_five_post'
    NOT_TOP_FIVE_POST = 'not_top_five_post'

    ABUSE_VILIFY = 'abuse_vilify'
    POLITICS_RELIGION = 'politics_religion'

    REWARD = [Rule::RuleType::TOPIC, Rule::RuleType::TOP_FIVE_POST, Rule::RuleType::NOT_TOP_FIVE_POST]
    PUNISHMENT = [Rule::RuleType::ABUSE_VILIFY, Rule::RuleType::POLITICS_RELIGION]
  end

  private
    
end
