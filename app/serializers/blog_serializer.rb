class BlogSerializer
  attributes :id, :author

  attribute :content do |blog|
    encoded = Base64.encode64(blog.content)
    encoded
  end
end
