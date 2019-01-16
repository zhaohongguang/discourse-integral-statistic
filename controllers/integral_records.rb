class ::IntegralRecordsController < ::ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_admin

  def index
    integral_records = IntegralRecord.includes(:user, :post)
    integral_records = integral_records.where(user_id: params[:user_id]) if params[:user_id].present?

    render_serialized(integral_records, IntegralRecordsSerializer)
  end

  def create
    
  end
end