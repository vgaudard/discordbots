#!/usr/bin/ruby

require '../root'

reactbot = Bot.new

reactbot.addMessageReaction(/^[a-z]{4,128}\.jpg$/i, lambda { |event|
    puts event.content
    path = 'images/' + event.content
    if File.exists? path
        return Message.new(event.content, path)
    else
        return nil
    end
})

reactbot.run
