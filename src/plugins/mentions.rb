#!/usr/bin/ruby

require 'json'

# Adds !pingme functionality, as specified in the project design documents
class Mentions
    def initialize mentionsPath
        @mentionsPath = mentionsPath
        if File.exist? mentionsPath
            @groups = JSON.parse(File.read(mentionsPath))
            puts JSON.pretty_generate(@groups)
        else
            @groups = Hash.new
        end
    end

    def updateFile
        puts JSON.pretty_generate(@groups)
        File.open(@mentionsPath, "w") do |f|
            f.write(@groups.to_json)
        end
    end

    def reactTo(event)
        authorID = event.author.id
        serverID = event.server.id.to_s
        case event.content
        when /^!pingme ([a-z-]+)$/i
            groupName = $1.downcase
            @groups[serverID] = Hash.new if not @groups.has_key? serverID
            @groups[serverID][groupName] = Array.new if not @groups[serverID].has_key? groupName
            @groups[serverID][groupName].push(authorID) if not @groups[serverID][groupName].include? authorID
            puts "Added #{event.author.username} (#{authorID}) to group #{groupName}"
            updateFile
            return
        when /^!leaveme ([a-z-]+)$/i
            groupName = $1.downcase
            return if not @groups.has_key? serverID
            return if not @groups[serverID].has_key? groupName
            @groups[serverID][groupName].delete(authorID)
            @groups[serverID].delete groupName if @groups[serverID][groupName].empty?
            puts "Removed #{event.author.username} (#{authorID}) from group #{groupName}"
            updateFile
        when /^!listgroups$/i
            if @groups.has_key? serverID
                return @groups[serverID].keys.join(", ")
            else
                return "No group in this server"
            end
        when /@([a-z-]+)/i # When someone mentions a group (in the form @groupname), we mention all participants in the group
            groupName = $1.downcase
            return @groups[serverID][groupName].map { |id| "<@#{id}>" }.join(" ") if @groups[serverID].has_key? groupName
        end
    end
end
