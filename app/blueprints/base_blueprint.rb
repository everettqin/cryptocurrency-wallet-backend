class BaseBlueprint < Blueprinter::Base

  identifier :identifier

  fields :created_at,
         :updated_at
end