module Events
  class BaseEvent
    class NoTopicError < StandardError; end

    def initialize(events_producer: EventsProducer)
      @events_producer = events_producer
    end

    def produce(payload)
      @events_producer.produce_sync(
        topic: topic_name,
        payload: {
          event_name: event_name,
          payload: payload
        }.to_json
      )
    end

    def event_name
      self.class.name.demodulize
    end

    def topic_name
      module_with_topic_name = self.class.module_parents.find { |mod| mod.respond_to?(:topic_name) }

      raise NoTopicError, 'Can not define topic name' unless module_with_topic_name

      module_with_topic_name.topic_name
    end
  end
end
