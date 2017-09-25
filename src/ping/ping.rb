#!/usr/bin/ruby

## Ping
class Ping
    def reactTo(event)
        if event.content == "ping"
            return "pong"
        else
            return ""
        end
    end
end
