module SchemaRegistry
  class Result
    attr_reader :result

    def initialize(validation_result)
      @result = validation_result
    end

    def success?
      result.empty?
    end

    def failure?
      result.any?
    end

    def failure
      result
    end

    def ==(other)
      result == other.result
    end
  end

  class Validator
    def initialize(loader:)
      @loader = loader
    end

    attr_reader :loader

    def validate(data, version: 1)
      schema_path = loader.schema_path(data[:event_name], version: data[:event_version])
      result = JSON::Validator.fully_validate(schema_path, data)

      Result.new(result)
    end
  end
end
