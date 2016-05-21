#!/usr/bin/ruby2.2

require 'discordrb'

bot = Discordrb::Bot.new token: '<TOKEN>', application_id: <app_id>

awesomeregex = /(?:\b)(di|cri)([^\s]{3,})/i
awesomeregexofnodoublon = /^([a-z])\1*(\1.*)$/
lastmessagetime = -1

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
        elsif method == "di"
            mess.capitalize!
        end
        if /bizu/i.match(mess)
            event.respond "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
        else
            event.respond mess
        end
    end
end

bot.run

