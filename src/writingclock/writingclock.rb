#!/usr/bin/ruby

class WritingClock
    # Warning : does not support daylight saving time
    def reactTo(event)
        if event.content == "!time"
            randomTime = rand(28).to_s.rjust(2, '0') + "h" + (rand (90) - 15).to_s.rjust(2, '0')
            return \
                "<:norm:356744948013596673>: `" + getTime('+02:00') + "`\n" + \
                ":cat:: `"                      + getTime('+09:00') + "`\n" + \
                ":leaves:: `"                   + getTime('+07:00') + "`\n" + \
                "<:kilt:356831960183603210>: `" + getTime('+01:00') + "`\n" + \
                "<:nom:356747206822461440>: `"  + getTime('+02:00') + "`\n" + \
                ":pizza:: `"                    + randomTime        + "`\n"
        else
            return ""
        end
    end

    def getTime(offset)
        return Time.now.getlocal(offset).strftime("%Hh%M")
    end
end