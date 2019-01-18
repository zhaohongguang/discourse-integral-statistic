require_dependency 'application_serializer'

class ::RulesSerializer < ::ApplicationSerializer

  attributes :id,
             :rule_type,
             :score,
             :description

end
