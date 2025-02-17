require 'rails_helper'

RSpec.describe Blogs::ImportService do
  let(:service) { described_class.new(file) }
  let(:valid_file) { File.open(Rails.root.join('spec/static_fixtures/files/valid_blogs.json')) }
  let(:invalid_file) { File.open(Rails.root.join('spec/static_fixtures/files/invalid_blogs.json')) }

  describe '#call' do
    context 'with valid input' do
      let(:file) { valid_file }

      before do
        allow(Blogs::BlogJsonValidator).to receive(:validate)
                                      .and_return([true, nil])
      end

      it 'successfully imports blogs' do
        result = service.call

        expect(Blog.all.count).to eq(2)

        expect(result).to eq({
          success: true,
          message: "Successfully imported blogs"
        })
      end

      it 'creates blogs with correct attributes' do
        service.call

        expect(Blog.first.author).to eq("Valid Author 1")
        expect(Blog.first.content).to eq("Valid Content")
        expect(Blog.first.slug).to start_with("valid-content-")
        expect(Blog.last.author).to eq("Valid Author 2")
        expect(Blog.last.content).to eq("Valid Content test")
        expect(Blog.last.slug).to start_with("valid-content-test-")
      end
    end

    context 'with missing file' do
      let(:file) { nil }

      it 'returns error message' do
        result = service.call

        expect(result).to eq({
                               success: false,
                               message: "Please upload a JSON file."
                             })
      end
    end

    context 'with invalid JSON format' do
      let(:file) { invalid_file }

      it 'returns parsing error message' do
        result = service.call

        expect(result[:success]).to be false
        expect(result[:message]).to eq("JSON Validation error: The property '#/0' did not contain a required property of 'author'")
      end
    end

    context 'with invalid JSON schema' do
      let(:file) { valid_file }
      let(:error_message) { "Invalid schema" }

      before do
        allow(Blogs::BlogJsonValidator).to receive(:validate)
                                      .and_return([false, error_message])
      end

      it 'returns validation error message' do
        result = service.call

        expect(result).to eq({
                               success: false,
                               message: "JSON Validation error: #{error_message}"
                             })
      end
    end

    context 'when blog creation fails' do
      let(:file) { valid_file }

      before do
        allow(Blogs::BlogJsonValidator).to receive(:validate)
                                      .and_return([true, nil])
        allow_any_instance_of(Blog).to receive(:save!)
                                         .and_raise(ActiveRecord::RecordInvalid.new(Blog.new))
      end

      it 'returns import error message' do
        result = service.call

        expect(result[:success]).to be false
        expect(result[:message]).to include("Failed to import")
      end

      it 'rolls back the transaction' do
        expect { service.call }.not_to change(Blog, :count)
      end
    end
  end
end
