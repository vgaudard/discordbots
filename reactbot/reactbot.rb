#!/usr/bin/ruby

require '../root'

reactbot = Bot.new
imagepathregex = /\b([a-z]{4,128}\.(jpg|gif|png))\b/i

reactbot.addMessageReaction(imagepathregex, lambda { |event|
    path = 'images/' + event.content[imagepathregex, 1]
    if File.exists? path
        return Message.new('', path)
    else
        return nil
    end
})

reactbot.run
