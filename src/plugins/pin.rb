#!/usr/bin/ruby

class Pin
    def initialize pinsPath
        @pinsPath = pinsPath
        if File.exist? pinsPath
            @pinnedMessages = JSON.parse(File.read(pinsPath))
        else
            @pinnedMessages = Hash.new
        end
    end

    def updateFile
        File.open(@pinsPath, "w") do |f|
            f.write(@pinnedMessages.to_json)
        end
    end

    def reactTo(event)
        if event.content == "📌"
            channel = event.channel
            return if not @pinnedMessages.has_key? channel.id.to_s
            return @pinnedMessages[channel.id.to_s].map { |id|
                message = channel.load_message id.to_i
                "#{message.author.username} wrote on #{message.timestamp.getlocal('+01:00')} #{"(edited on #{message.timestamp.getlocal('+01:00')})" if message.edited}\n\t" + message.content.sub(/\n/, "\n\t")
            }.join("\n=====\n")
        end
    end

    def reactToReaction(event)
        if event.emoji.name == "📌"
            channelID = event.channel.id.to_s
            messageID = event.message.id.to_s
            @pinnedMessages[channelID] = Array.new if not @pinnedMessages.has_key? channelID
            @pinnedMessages[channelID].push messageID if not @pinnedMessages[channelID].include? messageID
            updateFile
            return
        end
    end

    def reactToReactionRemoval(event)
        if event.emoji.name == "📌"
            puts "Hey"
            channelID = event.channel.id.to_s
            messageID = event.message.id.to_s
            @pinnedMessages[channelID].delete(messageID) if @pinnedMessages.has_key? channelID
            updateFile
            return
        end
    end
end
