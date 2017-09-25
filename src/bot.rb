#!/usr/bin/ruby

require 'discordrb'

class Bot
    def initialize(token, applicationId)
        @discordBot = Discordrb::Bot.new token: token, client_id: applicationId
        @plugins = Array.new

        @discordBot.message do |event|
            reactTo event
        end
    end

    def run
        @discordBot.run
    end

    def allowedToSend()
        returnValue = true
        @plugins.each {|plugin|
            returnValue &&= plugin.allowedToSend if defined? (plugin.allowedToSend)
        }
        return returnValue
    end

    def reactTo(event)
        @plugins.each { |plugin|
            if defined? (plugin.reactTo)
                response = plugin.reactTo(event)
                respond(event, response) if !response.empty? && allowedToSend
            end
        }
    end

    def respond(event, response)
        event.respond(response)
        @plugins.each { |plugin|
            plugin.onMessageSent(event, response) if defined? (plugin.onMessageSent)
        }
    end

    def addPlugin(plugin)
        @plugins.push(plugin)
    end

end

