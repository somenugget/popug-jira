require 'json'
require 'json-schema'

require_relative 'schema_registry/loader'
require_relative 'schema_registry/validator'

# Validates event schema
#
#   SchemaRegistry.validate_event(event_hash)
#
module SchemaRegistry
  # Method for validate event data by specific schema
  #
  # @param data [Hash] raw event data
  #
  # @return [<SchemaRegistry::Result>] Result object with list of validation errors or an empty list if schema is valid
  def self.validate_event(data)
    validator.validate(data)
  end

  def self.validator
    @validator ||= Validator.new(loader: loader)
  end

  def self.loader
    @loader ||= Loader.new(schemas_root_path: File.expand_path('../../schemas', __dir__))
  end
end
