module SchemaRegistry
  class Loader
    class NoSchemaError < StandardError; end

    def initialize(schemas_root_path:)
      @schemas_root_path = schemas_root_path
    end

    def schema_path(name, version:)
      dir_scan_results
        .find { |path| path.include?("#{name.underscore}/#{version}.json") }
        .tap { |path| raise NoSchemaError if path.blank? }
    end

    private

    attr_reader :schemas_root_path

    def dir_scan_results
      @dir_scan_results ||= Dir["#{schemas_root_path}/**/*.*"]
    end
  end
end
