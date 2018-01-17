#!/usr/bin/ruby

## Ping
class Ping
    def reactTo(event)
        return "pong" if event.content == "ping"
    end
end
