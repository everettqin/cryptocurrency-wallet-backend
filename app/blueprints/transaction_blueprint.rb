class TransactionBlueprint < BaseBlueprint

  fields :amount,
         :state,
         :currency_type,
         :source_user,
         :target_user,
         :processed_at

  association :source_user, blueprint: UserBlueprint
  association :target_user, blueprint: UserBlueprint
  association :versions, blueprint: VersionBlueprint
end