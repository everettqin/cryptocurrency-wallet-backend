class TransactionHistoryBlueprint < Blueprinter::Base

  fields :id,
         :item_type,
         :item_id,
         :event,
         :whodunnit,
         :created_at
end