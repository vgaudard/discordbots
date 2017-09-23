#!/usr/bin/ruby

# Simple rate limiter
# Don't react for a short time after a message
class RateLimiter
    def initialize(delay = 5)
        @lastMessageTime = Time.now - delay
        @delay = delay
    end

    def allowedToSend
        puts "RateLimiter checking"
        return Time.now > @lastMessageTime + @delay
    end

    def onMessageSent(event, response)
        puts "RateLimiter notified"
        @lastMessageTime = Time.now
    end
end
