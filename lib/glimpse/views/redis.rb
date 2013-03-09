require 'redis'

# Instrument Redis time
class Redis::Client
  class << self
    attr_accessor :query_time, :query_count
  end
  self.query_count = 0
  self.query_time = 0

  def call_with_timing(*args)
    start = Time.now
    call_without_timing(*args)
  ensure
    Redis::Client.query_time += (Time.now - start)
    Redis::Client.query_count += 1
  end
  alias_method_chain :call, :timing
end

module Glimpse
  module Views
    class Redis < View
      def duration
        ::Redis::Client.query_time
      end

      def formatted_duration
        "%.2fms" % (duration * 1000)
      end

      def calls
        ::Redis::Client.query_count
      end

      def results
        { :duration => formatted_duration, :calls => calls }
      end

      private

      def setup_subscribers
        # Reset each counter when a new request starts
        subscribe 'start_processing.action_controller' do
          ::Redis::Client.query_time = 0
          ::Redis::Client.query_count = 0
        end
      end
    end
  end
end
