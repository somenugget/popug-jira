ENV['RAILS_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require ::File.expand_path('config/environment', __dir__)
Rails.application.eager_load!

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers' => '127.0.0.1:9093' }
    config.client_id = 'task-tracker'
    config.logger = Rails.logger
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  routes.draw do
    topic 'users-stream' do
      consumer UsersStreamConsumer
    end

    topic 'tasks-stream' do
      consumer TasksStreamConsumer
    end

    topic 'tasks-business-flow' do
      consumer TasksConsumer
    end
  end
end

KarafkaApp.run!
