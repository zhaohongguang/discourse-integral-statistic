class ::RulesController < ::ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def index
    rules = Rule.where(rule_type: Rule::RuleType::PUNISHMENT)

    render_serialized(rules, RulesSerializer)
  end
end