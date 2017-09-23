#!/usr/bin/ruby

## Ping
class Ping
    def reactTo(event)
        puts "Ping trying to react"
        if event.content == "ping"
            puts "Pong"
            return "pong"
        else
            return ""
        end
    end
end
