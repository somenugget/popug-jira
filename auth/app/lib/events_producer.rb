class EventsProducer
  KAFKA_CONFIG = {
    'bootstrap.servers': 'localhost:9093'
  }.freeze

  class << self
    def create_producer
      WaterDrop::Producer.new do |config|
        config.kafka = KAFKA_CONFIG
        config.deliver = true
      end
    end

    def with_producer
      raise ArgumentError unless block_given?

      producer = create_producer

      yield producer

      producer.close
    end

    def produce_sync(**args)
      with_producer do |producer|
        pp producer.produce_sync(args)
      end
    end
  end
end
