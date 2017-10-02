#!/usr/bin/ruby

# Toggle reactions
# Use `!dip stop` to prevent reactions until `!dip start`
# Use `!dip start` to enable reactions
# Use `!dip pause [durations]` to pause reactions (durations in seconds, defaults to 15*60)
class TaGueule
    def initialize(shortDelay = 15 * 60)
        @shortDelay = shortDelay
        @until = Time.now
        @stopped = false
    end

    def allowedToSend
        return Time.now > @until && !@stopped
    end

    def reactTo(event)
        case event.content
        when /^dip stop$|meurs.*dip/i
            @stopped = true
        when /^!dip start$|reviens.*dip/i
            @until = Time.now
            @stopped = false
        when /^!dip pause$|ta gueule.*dip|tais.toi.*dip/i
            @until = Time.now + @shortDelay
        when /^!dip pause (\S+)$/i
            @until = Time.now + $1.to_i
        end
    end
end
