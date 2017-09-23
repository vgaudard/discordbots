#!/usr/bin/ruby

require 'discordrb'

class Bot
    def initialize(token, applicationId)
        @discordBot = Discordrb::Bot.new token: token, client_id: applicationId
        @plugins = Array.new

        @discordBot.message do |event|
            puts "Received message"
            reactTo event
        end
    end

    def run
        @discordBot.run
    end

    def allowedToSend()
        puts "Start checking"
        returnValue = true
        @plugins.each {|plugin|
            puts "Checking message with plugin :", plugin
            puts "Defined!" if defined? plugin.allowedToSend
            puts "Allowed to send ?: ", plugin.allowedToSend if defined? plugin.allowedToSend
            returnValue &&= plugin.allowedToSend if defined? (plugin.allowedToSend)
        }
        return returnValue
    end

    def reactTo(event)
        puts "Finding reactions"
        @plugins.each { |plugin|
            if defined? (plugin.reactTo)
                response = plugin.reactTo(event)
                respond(event, response) if !response.empty? && allowedToSend
            end
        }
    end

    def respond(event, response)
        puts "Responding"
        event.respond(response)
        @plugins.each { |plugin|
            plugin.onMessageSent(event, response) if defined? (plugin.onMessageSent)
        }
    end

    def addPlugin(plugin)
        puts "Added plugin :", plugin
        @plugins.push(plugin)
    end

end

