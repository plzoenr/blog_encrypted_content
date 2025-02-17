class BlogSerializer
  identifier :id

  field :author

  attribute :content do |blog|
    encoded = Base64.encode64(blog.content)
    encoded
  end
end
