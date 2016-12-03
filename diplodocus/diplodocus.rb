#!/usr/bin/ruby

require 'discordrb'

tokenFile = File.open("token", "r")
applicationIdFile = File.open("application_id", "r")
bot = Discordrb::Bot.new token: tokenFile.read.strip, client_id: applicationIdFile.read.to_i
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
        method = event.content[awesomeregex, 1].downcase
        mess = event.content[awesomeregex, 2]
        send = true
        if awesomeregexofnodoublon.match(mess)
            mess = mess[awesomeregexofnodoublon, 2]
        end
        if method == "cri"
            mess.upcase!
        elsif method == "di" or method == "dy"
            mess.capitalize!
        end
        if /[h_*][bВß͕͗𝓫͕͕͗͗В͕͕͕͗͗͗͠𝓫͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠𝒷͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠𝔟͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠𝕓͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠ᗷ͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠𝚋͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠ʙ͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠в͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠в͕͕͗͗͠В͕͕͗͗͠ß͕͕͗͗͠ɮ͕͕͗͗͠В͕͕͗͗͠ß͕͗ß͕͗][h_]*[ilѓíyÿŷўtḷýìʃjłťțîïļįİİiĵ͕͗𝓲͕͕͗͗𝓵͕͕͗͗ѓ͕͕͗͗𝓲͕͕́͗͗𝔂͕͕͗͗ÿ͕͕͗͗ŷ͕͕͗͗ў͕͕͗͗𝓽͕͕͗͗ḷ͕͕͗͗ý͕͕͗͗𝓲͕͕̀͗͗ʃ͕͕͗͗𝓳͕͕͗͗ł͕͕͗͗ť͕͕͗͗ț͕͕͗͗𝓲͕͕̂͗͗𝓲͕͕̈͗͗ļ͕͕͗͗į͕͕͗͗İ͕͕͗͗İ͕͕͗͗𝓲͕͕͗͗ĵ͕͕͗͗𝒾͕͕͗͗𝓁͕͕͗͗ѓ͕͕͗͗𝒾͕͕́͗͗𝓎͕͕͗͗ÿ͕͕͗͗ŷ͕͕͗͗ў͕͕͗͗𝓉͕͕͗͗ḷ͕͕͗͗ý͕͕͗͗𝒾͕͕̀͗͗ʃ͕͕͗͗𝒿͕͕͗͗ł͕͕͗͗ť͕͕͗͗ț͕͕͗͗𝒾͕͕̂͗͗𝒾͕͕̈͗͗ļ͕͕͗͗į͕͕͗͗İ͕͕͗͗İ͕͕͗͗𝒾͕͕͗͗ĵ͕͕͗͗𝔦͕͕͗͗𝔩͕͕͗͗ѓ͕͕͗͗𝔦͕͕́͗͗𝑦͕͕͗͗ÿ͕͕͗͗ŷ͕͕͗͗ў͕͕͗͗𝔱͕͕͗͗ḷ͕͕͗͗ý͕͕͗͗𝔦͕͕̀͗͗ʃ͕͕͗͗𝔧͕͕͗͗ł͕͕͗͗ť͕͕͗͗ț͕͕͗͗𝔦͕͕̂͗͗𝔦͕͕̈͗͗ļ͕͕͗͗į͕͕͗͗İ͕͕͗͗İ͕͕͗͗𝔦͕͕͗͗ĵ͕͕͗͗𝕚͕͕͗͗𝕝͕͕͗͗ѓ͕͕͗͗𝕚͕͕́͗͗𝕪͕͕͗͗ÿ͕͕͗͗ŷ͕͕͗͗ў͕͕͗͗𝕥͕͕͗͗ḷ͕͕͗͗ý͕͕͗͗𝕚͕͕̀͗͗ʃ͕͕͗͗𝕛͕͕͗͗ł͕͕͗͗ť͕͕͗͗ț͕͕͗͗𝕚͕͕̂͗͗𝕚͕͕̈͗͗ļ͕͕͗͗į͕͕͗͗İ͕͕͗͗İ͕͕͗͗𝕚͕͕͗͗ĵ͕͗|!*()\\\/][h_]*[szšžʒŝ͕͗𝓼͕͕͗͗𝔃͕͕͗͗š͕͕͗͗ž͕͕͗͗ʒ͕͕͗͗ŝ͕͕͗͗𝓈͕͕͗͗𝓏͕͕͗͗š͕͕͗͗ž͕͕͗͗ʒ͕͕͗͗ŝ͕͕͗͗𝔰͕͕͗͗𝔷͕͕͗͗š͕͕͗͗ž͕͕͗͗ʒ͕͕͗͗ŝ͕͗][h_]*[u𝓾͕͗ǔŭйűѝüùųµūû͕͗𝓾͕͕͗͗﮳͕͕͗͗���͕͕͕͕͕͕͕͗͗͗͗͗͗͗ǔ͕͕͗͗ŭ͕͕͗͗й͕͕͗͗ű͕͕͗͗ѝ͕͕͗͗𝓾͕͕̈͗͗𝓾͕͕̀͗͗ų͕͕͗͗µ͕͕͗͗ū͕͕͗͗𝓾͕͕̂͗͗𝓊͕͕͗͗﮳͕͕͗͗���͕͕͕͕͕͕͕͗͗͗͗͗͗͗ǔ͕͕͗͗ŭ͕͕͗͗й͕͕͗͗ű͕͕͗͗ѝ͕͕͗͗𝓊͕͕̈͗͗𝓊͕͕̀͗͗ų͕͕͗͗µ͕͕͗͗ū͕͕͗͗𝓊͕̂͗]/i.match(mess)
            message = message = event.respond "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
        elsif /^Rect$/.match(mess)
            message = event.respond "GET REKT!"
        elsif /^Sputes?$/.match(mess)
            message = event.respond "PUTE!"
        elsif /^jkstra$/i.match(mess)
            message = event.respond "jsk... jkst... jkj... Roy-Warshall!"
        else
            if  rand(5) == 0
                message = event.respond mess
                send = true
            end
        end
        if send
            lastmessagetime = event.timestamp
            messagesAnswered[ event.message.id ] = message
        end
    end
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

