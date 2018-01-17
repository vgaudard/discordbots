#!/usr/bin/ruby


class Superuser
    def initialize(secret)
        @superuserIdList = Array.new
        @secret = secret
        @@instance = self
    end

    def reactTo(event)
        case event.content
        when "!checksu"
            return isSuperuser(event.author.id) ? "Yep" : "Nope"
        when /^!su ([a-zA-Z0-9]+)$/
            puts "[SU] #{event.author.username} trying to su"
            if $1 == @secret
                @superuserIdList.push event.author.id
                puts "[SU] #{event.author.username} added"
            end
        end
    end

    def isSuperuser(userid)
        return @superuserIdList.include? userid
    end

    def self.isSuperuser(userid)
        return @@instance.isSuperuser userid
    end
end
