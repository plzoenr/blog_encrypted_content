class BlogJsonValidator
  schema_path = Rails.root.join('app', 'schemas', 'blog_schema.json').freeze
  BLOG_SCHEMA = JSON.parse(File.read(schema_path)).freeze

  def self.validate(data)
    JSON::Validator.validate!(BLOG_SCHEMA, data)
    true
  rescue JSON::Schema::ValidationError => e
    [false, e.message]
  end
end
