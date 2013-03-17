require 'redis'
require 'atomic'

# Instrument Redis time
class Redis::Client
  class << self
    attr_accessor :query_time, :query_count
  end
  self.query_count = Atomic.new(0)
  self.query_time = Atomic.new(0)

  def call_with_timing(*args, &block)
    start = Time.now
    call_without_timing(*args, &block)
  ensure
    duration = (Time.now - start)
    Redis::Client.query_time.update { |value| value + duration }
    Redis::Client.query_count.update { |value| value + 1 }
  end
  alias_method_chain :call, :timing
end

module Glimpse
  module Views
    class Redis < View
      def duration
        ::Redis::Client.query_time.value
      end

      def formatted_duration
        ms = duration * 1000
        if ms >= 1000
          "%.2fms" % ms
        else
          "%.0fms" % ms
        end
      end

      def calls
        ::Redis::Client.query_count.value
      end

      def results
        { :duration => formatted_duration, :calls => calls }
      end

      private

      def setup_subscribers
        # Reset each counter when a new request starts
        subscribe 'start_processing.action_controller' do
          ::Redis::Client.query_time.value = 0
          ::Redis::Client.query_count.value = 0
        end
      end
    end
  end
end
