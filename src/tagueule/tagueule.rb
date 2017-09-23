#!/usr/bin/ruby

# Toggle reactions
# Use `!dip stop` to prevent reactions until `!dip start`
# Use `!dip start` to enable reactions
# Use `!dip pause [durations]` to pause reactions (durations in seconds, defaults to 15*60)
class TaGueule
    def initialize(shortDelay = 15 * 60)
        @stopRegex = /^!dip stop$|meurs.*dip/i
        @startRegex = /^!dip start$|reviens.*dip/i
        @shortPauseRegex = /^!dip pause$|ta gueule.*dip|tais.toi.*dip/i
        @pauseRegex = /^!dip pause (\S+)$/i
        @helpRegex = /^!dip help$/
        @shortDelay = shortDelay
        @until = Time.now
        @stopped = false
    end

    def allowedToSend
        puts "TaGueule checking"
        return Time.now > @until && !@stopped
    end

    def reactTo(event)
        puts "TaGueule trying to react"
        if @stopRegex.match event.content
            @stopped = true
        elsif @startRegex.match event.content
            @until = Time.now
            @stopped = false
        elsif @shortPauseRegex.match event.content
            @until = Time.now + @shortDelay
        elsif @pauseRegex.match event.content
            delay = event.content[@pauseRegex].to_i
            @until = Time.now + delay
        elsif @helpRegex.match event.content
            return \
                "`!dip stop`: prevent reactions until `!dip start`\n" + \
                "`!dip start`: enable reactions\n" + \
                "`!dip pause [durations]`: pause reactions (durations in seconds, defaults to 15*60)\n"
        end
        return ""
    end
end
