class ::IntegralRecordsController < ::ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def index
    integral_records = IntegralRecord.includes(:user, :post).order(created_at: :desc)
    integral_records = integral_records.where(user_id: params[:user_id]) if params[:user_id].present?

    render_serialized(integral_records, IntegralRecordsSerializer)
  end

  def create
    # rule = Rule.where(id: params[:rule_id]).last
    # options = { user_id: params[:user_id], rule_id: params[:rule_id], score: rule.score.to_f, note: params[:note] }
    # IntegralRecord.create_integral_record(options)
    render_json_dump(params)
  end
end