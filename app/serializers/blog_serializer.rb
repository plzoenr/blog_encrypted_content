class BlogSerializer < Blueprinter::Base
  identifier :id

  field :author

  field :content_base64
end
