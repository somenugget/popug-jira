module Events
  class BaseEvent
    class NoTopicError < StandardError; end

    class SchemaValidationError < StandardError; end

    def initialize(events_producer: EventsProducer)
      @events_producer = events_producer
    end

    def produce(payload)
      raise ArgumentError, 'Payload is not a Hash' unless payload.is_a?(Hash)

      event = build_event(payload)

      with_event_validation(event) do
        @events_producer.produce_sync(
          topic: topic_name,
          payload: event.to_json
        )
      end
    end

    private

    def build_event(payload)
      {
        event_id: SecureRandom.uuid,
        event_time: DateTime.current.to_s,
        event_version: self.class::EVENT_VERSION,
        event_name: event_name,
        producer: Rails.application.class.name.deconstantize,
        payload: payload
      }
    end

    def event_name
      self.class.name.demodulize
    end

    def topic_name
      module_with_topic_name = self.class.module_parents.find { |mod| mod.respond_to?(:topic_name) }

      raise NoTopicError, 'Can not define topic name' unless module_with_topic_name

      module_with_topic_name.topic_name
    end

    def with_event_validation(event)
      result = SchemaRegistry.validate_event(event, version: event[:event_version])

      raise SchemaValidationError, result.failure.join("\n") if result.failure?

      yield
    end
  end
end
