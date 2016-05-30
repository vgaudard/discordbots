#!/usr/bin/ruby2

require 'discordrb'

bot = Discordrb::Bot.new token: '', application_id:

awesomeregex = /(?:\b)(di|dy|cri)(\S{3,}?)\b/i
awesomeregexofnodoublon = /^([a-z])\1*(\1.*)$/
lastmessagetime = -1
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

bot.message_edit() do |event|
    mess = event.message
    if messagesAnswered.key?(mess.id)
        messagesAnswered[ mess.id ].edit(mess.author.display_name + " est lâche!")
    end
end
bot.run

