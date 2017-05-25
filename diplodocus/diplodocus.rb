#!/usr/bin/ruby

require '../root'

awesomeregex = /\b((?:d|cr)[iy])(\S{3,}?)\b/i
awesomeregexofnodoublon = /^([a-z])\1*(\1.*)$/
merciregex = /(good|merci|nice|bien|cool|thx|thanks|thank|perfect|parfait|perf).*dip/i
notregex = /not|pas/i
tagueuleregex = /(ta gueule|tais toi|shut).*dip/i

diplodocus = Bot.new
thanks_answers = JSON.parse(File.read("thanks.json"))

diplodocus.addMessageReaction(merciregex, lambda { |event|
    if not notregex.match(event.content)
        return thanks_answers.sample
    end
}, 80)

diplodocus.addMessageReaction(tagueuleregex, lambda { |event|
    diplodocus.setTagueuleTime( event.timestamp.to_i )
})

diplodocus.addMessageReaction(awesomeregex, lambda { |event|
    method = event.content[awesomeregex, 1].downcase
    mess = event.content[awesomeregex, 2]
    if awesomeregexofnodoublon.match(mess) # Remove leading duplicate characters
        mess = mess[awesomeregexofnodoublon, 2]
    end
    case method
    when /^d[iy]/i
        mess.capitalize!
    when /^cr[iy]/i
        mess.upcase!
    else
        mess.downcase!
    end
    return mess
}, 50, 20, lambda { |mess|
    return mess.author.display_name + " est lâche!"
})

diplodocus.addMessageReaction(/\bdirect\b/i, lambda { |event|
    return "GET REKT!"
}, 200)

diplodocus.addMessageReaction(/\bdispute\b/i, lambda { |event|
    return "PUTE!"
}, 200)

diplodocus.addMessageReaction(/\bdijkstra\b/i, lambda { |event|
    return "jsk... jkst... jkj... Roy-Warshall!"
}, 200)

diplodocus.addMessageReaction(/\balarm(?:er?|(é|ant)e?s?)?\b/i, lambda { |event|
        return "ALARME!\nhttps://www.youtube.com/watch?v=TqDsMEOYA9g"
}, 200)

diplodocus.addMessageReaction(/b[ilíìî][sz][uù]/i, lambda { |event|
    return "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
}, 200, 80)

diplodocus.run
