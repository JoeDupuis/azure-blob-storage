# frozen_string_literal: true

module AzureBlob
  class Blob
    def initialize(response)
      @response = response
    end

    def content_type
      response.content_type
    end

    def content_disposition
      response["content-disposition"]
    end

    def checksum
      response["content-md5"]
    end

    def size
      response.content_length
    end

    def present?
      response.code == "200"
    end

    def metadata
      @metadata || response
        .to_hash
        .select { |key, _| key.start_with?("x-ms-meta") }
        .transform_values(&:first)
        .transform_keys { |key| key.delete_prefix("x-ms-meta-").to_sym }
    end

    private

    attr_reader :response
  end
end