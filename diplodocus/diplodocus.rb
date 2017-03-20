#!/usr/bin/ruby

require 'discordrb'

tokenFile = File.open("token", "r")
applicationIdFile = File.open("application_id", "r")
bot = Discordrb::Bot.new token: tokenFile.read.strip, client_id: applicationIdFile.read.to_i
tokenFile.close
applicationIdFile.close

awesomeregex = /(?:\b)(di|dy|cri)(\S{3,}?)\b/i
awesomeregexofnodoublon = /^([a-z])\1*(\1.*)$/
merciregex = /(good|merci|nice|bien|cool|thx|thanks|thank|perfect|parfait|perf).*dip/i
notregex = /not|pas/i
perduregex = /(perdu|lost|lose|perdre)\b/i
lastmessagetime = -1

thanks_answers = [  "Oh you! https://giphy.com/gifs/whatever-oh-you-uiVH8ETzr9nZm",
                    "De rien !",
                    "ENFIN !!! Ca fait des mois que je reste eveillé à longueur de journée pour votre plaisir, et pas de merci ! Et enfin quelqu'un prend en compte mon existence ! Merci !",
                    "Ouais, ça mérite au moins ça...",
                    "Je ne fais que mon travail... http://i3.kym-cdn.com/entries/icons/original/000/014/711/1380697092809.jpg",
                    "De rien, ma belle !",
                    "Tu veux qu'on se retrouve après le travail ? http://www.excusememe.com/pics/imagebase/5099.gifs",
                    "Tu veux qu'on se retrouve après le travail ? https://s-media-cache-ak0.pinimg.com/originals/64/24/2f/64242f27f1afa3b669982c641e31bf62.jpg",
                    "Tu veux qu'on se retrouve après le travail ? http://images.halloweencostumes.com/products/32430/1-2/adult-al-gator-costume.jpg",
                    "Tu te fous de ma gueule, c'est ça ?",
                    "Gracias ! https://owncloud.vgaudard.com/index.php/apps/files_sharing/ajax/publicpreview.php?x=1366&y=322&a=true&file=gracias_dinosauro.png&t=FtNRWKa9T9nkb7o&scalingup=0",
                    "Ah! Je savais que ça allait te plaire.",
                    "Tu trouves ? https://cdn.drawception.com/images/panels/2015/3-28/Gdj3GYHa8C-5.png",
                    "Yo solo hace mi trabajo ! No puede usted pagarme ? Tengo hambre...",
                    "谢谢大家！谢谢你，我不会让我鞭那一夜！",
                    "Cool ! J'avais peur de *perdre* mon travail.",
                    "kthxbye",
                    "C'est un plaisir de faire ça pour toi !",
                    "J'ai un bon professeur !",
                    "Bon, on va pas en faire tout un plat non plus.",
                    "Wesh gro sa fé zizir https://s-media-cache-ak0.pinimg.com/736x/0e/22/ed/0e22ed251bdf256052685cfbbfe30a69.jpg",
                    "Danke https://i.ytimg.com/vi/hPutWCpbFBs/maxresdefault.jpg",
                    "Rawr matey, i be glad you like this, but i be no squiffy ! Now where's them doubloons ? https://ih1.redbubble.net/image.120312598.0390/flat,800x800,075,f.u2.jpg",
                    "Dis plutôt merci à mon maitre adoré ! C'est grâce à lui que je sais faire tout ça.",
                    "https://www.youtube.com/watch?v=j3IJQXwah0E",
                    "https://s-media-cache-ak0.pinimg.com/originals/a6/c1/89/a6c189a2dee8a689eb4bb1688c03dd0c.jpg",
                    "https://www.youtube.com/watch?v=OcfqDPAy7zc&t=3",
                    "https://www.youtube.com/watch?v=79DijItQXMM",
                    "https://owncloud.vgaudard.com/index.php/apps/files_sharing/ajax/publicpreview.php?x=1366&y=322&a=true&file=elvish_welcome.png&t=N0NFTXOQNOV4UZR&scalingup=0",
                    "Tu crois que je fais ça pour toi ?",
                    "Ouais, je trouve aussi que c'était cool !"]

losing_protection_message = ["We're not going to lose another soldier!",
                             "Tenez bon !",
                             "Il faut éviter ce massacre",
                             "Fermez vos yeux !",
                             "Je ne veux pas voir ça"]
losing_protection_picture = ["https://i.imgur.com/qecLpkU.gifv",
                             "https://i.imgur.com/n5yN6Uo.gifv",
                             "https://i.imgur.com/lZEeZ8z.gifv",
                             "https://i.imgur.com/sTVcGYc.gifv",
                             "https://i.imgur.com/AGXXCNz.gifv",
                             "https://i.redd.it/figdnt37g2dy.jpg",
                             "https://i.imgur.com/arVW3Ie.jpg",
                             "https://i.imgur.com/ZJh6DKq.gifv",
                             "https://i.imgur.com/nO8rZ.gif",
                             "https://i.imgur.com/KpeIJP0.gifv",
                             "https://i.imgur.com/bSoPVAX.gifv"]

# This should not be a problem unless the server stays on at all times, which it does now, but idc
messagesAnswered = {}

#bot.message(in: "#general") do |event|
bot.message() do |event|
    if merciregex.match(event.content) && event.timestamp.to_i - lastmessagetime.to_i > 5 && !event.from_bot?
        if not notregex.match(event.content)
            mess = thanks_answers.sample
            event.respond mess
            lastmessagetime = event.timestamp
        end
    elsif perduregex.match(event.content) && event.timestamp.to_i - lastmessagetime.to_i > 5 && !event.from_bot?
        if rand(5) == 0
            event.respond losing_protection_message.sample
            event.respond losing_protection_picture.sample
            lastmessagetime = event.timestamp
        end
    elsif awesomeregex.match(event.content) && event.timestamp.to_i - lastmessagetime.to_i > 5 && !event.from_bot?
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
        if /b[ilíìî|!*()\\\/][sz][uù]/i.match(mess)
            message = message = event.respond "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
        elsif /^Rect$/.match(mess)
            message = event.respond "GET REKT!"
        elsif /^Sputes?$/.match(mess)
            message = event.respond "PUTE!"
        elsif /^jkstra$/i.match(mess)
            message = event.respond "jsk... jkst... jkj... Roy-Warshall!"
        else
            if rand(5) == 0
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

