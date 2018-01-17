#!/usr/bin/ruby

class WritingClock
    # Warning : does not support daylight saving time
    def reactTo(event)
        if event.content == "!time"
            randomTime = rand(28).to_s.rjust(2, '0') + "h" + (rand (90) - 15).to_s.rjust(2, '0')
            return \
                "<:bzh:356744042224025600>: `"  + getTime('+01:00') + "`\n" + \
                ":cat:: `"                      + getTime('+09:00') + "`\n" + \
                ":leaves:: `"                   + getTime('+07:00') + "`\n" + \
                "<:kilt:356831960183603210>: `" + getTime('+00:00') + "`\n" + \
                "<:nom:356747206822461440>: `"  + getTime('+01:00') + "`\n" + \
                ":pizza:: `"                    + randomTime        + "`\n"
        end
    end

    def getTime(offset)
        return Time.now.getlocal(offset).strftime("%Hh%M")
    end

    private :getTime
end
