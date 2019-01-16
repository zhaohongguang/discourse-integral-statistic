require_dependency 'application_serializer'

class ::IntegralRecordsSerializer < ::ApplicationSerializer

  attributes :id,
             :integral_type,
             :user_id,
             :username,
             :score,
             :created_at,
             :post_id,

  def integral_type
    object.try(:rule).try(:rule_type)
  end

  def username
    object.try(:user).try(:username)
  end

end
