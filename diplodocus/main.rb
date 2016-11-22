#!/usr/bin/ruby

require 'discordrb'

tokenFile = File.open("token", "r")
applicationIdFile = File.open("application_id", "r")
bot = Discordrb::Bot.new token: tokenFile.read, application_id: applicationIdFile.read
tokenFile.close
applicationIdFile.close

awesomeregex = /(?:\b)(di|dy|cri)(\S{3,}?)\b/i
awesomeregexofnodoublon = /^([a-z])\1*(\1.*)$/
lastmessagetime = -1

# This should not be a problem until the server stays on at all times
messagesAnswered = {}

#bot.message(in: "#general") do |event|
bot.message() do |event|
    if awesomeregex.match(event.content) && event.timestamp.to_i - lastmessagetime.to_i > 5 && !event.from_bot?
        lastmessagetime = event.timestamp
        method = event.content[awesomeregex, 1].downcase
        mess = event.content[awesomeregex, 2]
        if awesomeregexofnodoublon.match(mess)
            mess = mess[awesomeregexofnodoublon, 2]
        end
        if method == "cri"
            mess.upcase!
        elsif method == "di" or method == "dy"
            mess.capitalize!
        end
        if /b[ilíìî|!*()\\\/][sz][uù]/i.match(mess)
            message = message = event.respond "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
        elsif /^Rect$/.match(mess)
            message = event.respond "GET REKT!"
        elsif /^Sputes?$/.match(mess)
            message = event.respond "PUTE!"
        else
            message = event.respond mess
        end
        messagesAnswered[ event.message.id ] = message
    end
end

bot.message ({contains: /\bsbouvier/i}) do |event|
    event.respond("Fragile...")
end
bot.message ({contains: /\balarm(?:er?|(é|ant)e?s?)?\b/i}) do |event|
    if event.timestamp.to_i - lastmessagetime.to_i > 5 && !event.from_bot?
        lastmessagetime = event.timestamp
        event.respond("ALARME!")
        event.respond("https://www.youtube.com/watch?v=TqDsMEOYA9g")
    end
end

bot.message_edit() do |event|
    mess = event.message
    if messagesAnswered.key?(mess.id)
        messagesAnswered[ mess.id ].edit(mess.author.display_name + " est lâche!")
    end
end

bot.run

