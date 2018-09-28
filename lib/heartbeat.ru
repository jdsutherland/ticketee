module Heartbeat
  class Application
    def self.call(env)
      [ 200, { 'Content-Type' => 'text/plain' }, ["Classy!"] ]
    end
  end
end

run Heartbeat::Application
