#!/usr/bin/ruby

require_relative 'superuser'

class Puppet
    def initialize
        @target = nil
        @passphrase = nil
    end

    def reactTo(event)
        return if not Superuser.isSuperuser(event.author.id)
        case event.content
        when /^!aim (.*)$/
            @passphrase = $1
        when @passphrase
            @target = event
        when /^!shoot (.*)$/
            @target.respond $1
        end
        return
    end
end
