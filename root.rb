#!/usr/bin/ruby

require 'discordrb'

MessageEditReaction = Struct.new(:message, :reaction, :date)
MessageReaction = Struct.new(:regex, :answerFunction, :priority, :probability, :editReactionFunction)
Message = Struct.new(:caption, :filepath)

class Bot

    def initialize()
        token = File.read("token").strip
        applicationId = File.read("application_id").to_i
        @bot = Discordrb::Bot.new token: token, client_id: applicationId
        @tagueule_lasttime = -1
        @tagueule_defaultdelay = 15 * 60 # 15 minutes
        @lastmessagetime = -1
        @message_delay = 5 # 5 seconds
        @cleaning_delay = 60 * 60 * 24 # 1 day
        @cleaning_lasttime = Time.now
        @reactions = []
        @messagesAnswered = {}

        ### Message edit management
        @bot.message_edit() do |event|
            mess = event.message
            if @messagesAnswered.key?(mess.id)
                messageEditReaction = @messagesAnswered[mess.id]
                messageEditReaction.message.edit(messageEditReaction.reaction.call(mess))
            end
        end

        ### Message answer management
        @bot.message() do |event|
            reaction = nil
            priorityMax = -1
            @reactions.each { |reac|
                if reac.priority > priorityMax && reac.regex.match(event.content)
                    priorityMax = reac.priority
                    reaction = reac
                end
            }
            date = event.timestamp.to_i
            if (date < @tagueule_lasttime + @tagueule_defaultdelay) || (reaction == nil) || (date - @lastmessagetime < @message_delay) || (event.from_bot?) || (rand(100) > reaction.probability)
                next
            end
            answer = reaction.answerFunction.call(event)
            if answer == nil
                next
            end
            @lastmessagetime = date
            message = nil
            if answer.is_a? String
                answer = Message.new(answer, nil)
            end
            if answer.filepath != nil
                file = File.open(answer.filepath)
                message = event.send_file(file, caption: answer.caption)
                file.close
            else
                message = event.respond(answer.caption)
            end
            if reaction.editReactionFunction != nil
                messageEditReaction = MessageEditReaction.new(message, reaction.editReactionFunction, Time.now)
                @messagesAnswered[event.message.id] = messageEditReaction
            end
        end

        ### Cleaning management
        Thread.new do
            loop do
                sleep cleaning_delay
                @messagesAnswered.delete_if { |k,v| v.date < @cleaning_lasttime }
                @cleaning_lasttime = Time.now
            end
        end
    end

    # Adds a possible reaction
    # Note: There is only one reaction to a single message
    # Params:
    # +messageRegex+:: Regular expression to check if this reaction should be used against a given message
    # +answerFunction+:: Function returning a string containing the message to be sent. It has a single parameter: the event object
    # +priority+:: Priority used to select the reaction. The selected reaction is the one with the highest priority.
    # +probability+:: Percentage of the time this reaction should be used. (Used after selecting a reaction)
    # +editReactionFunction+:: Function returning a string containing the new content of the message to be edited. It is called when an answered message is edited.
    def addMessageReaction(messageRegex, answerFunction, priority = 100, probability = 100, editReactionFunction = nil)
        @reactions.push(MessageReaction.new(messageRegex, answerFunction, priority, probability, editReactionFunction))
    end

    def setTagueuleTime(time)
        @tagueule_lasttime = time
    end

    def run
        @bot.run
    end
end


# Because over-engineered jokes are always the best
