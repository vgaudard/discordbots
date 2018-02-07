#!/usr/bin/ruby

class WritingClock
    def initialize timePath
        @timeZones = JSON.parse(File.read(timePath))
    end

    # Warning : does not support daylight saving time
    def reactTo(event)
        if event.content == "!time"
            return @timeZones.map { |k,v| k + ": `" + getTime(v) + "`"}.join("\n")
        end
    end

    def getTime(offset)
        return Time.now.getlocal(offset).strftime("%Hh%M")
    end

    private :getTime
end
