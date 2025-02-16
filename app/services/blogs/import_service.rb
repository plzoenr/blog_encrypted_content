# app/services/blog_import_service.rb
module Blogs
  class ImportService < ApplicationService
    attr_reader :file
    def initialize(file)
      @file = file
    end

    def call
      validate_file_presence
      parsed_data = parse_json_file
      validate_json_schema(parsed_data)
      import_blogs(parsed_data)

      { success: true, message: "Successfully imported blogs" }
    rescue StandardError => e
      { success: false, message: e.message }
    end

    private

    def validate_file_presence
      raise "Please upload a JSON file." if @file.blank?
    end

    def parse_json_file
      JSON.parse(@file.read)
    rescue JSON::ParserError => e
      raise "Invalid JSON format: #{e.message}"
    end

    def validate_json_schema(json_data)
      validation_result, error_message = BlogJsonValidator.validate(json_data)
      raise "JSON Validation error: #{error_message}" unless validation_result
    end

    def import_blogs(json_data)
      ActiveRecord::Base.transaction do
        json_data.each do |post|
          Blog.create!(author: post["author"], content: post["content"])
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      raise "Failed to import: #{e.message}"
    end
  end
end
