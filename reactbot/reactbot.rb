#!/usr/bin/ruby

require 'open-uri'
require '../root'

reactbot = Bot.new

authorizedUsers = JSON.parse(File.read("authorized_users.json"))

imagepathregex = /\b([a-z]{4,128}\.(jpg|gif|png))\b/i
reactbot.addMessageReaction(imagepathregex, lambda { |event|
    path = File.join('images', event.content[imagepathregex, 1].downcase)
    if File.exists? path
        return Message.new('', path)
    else
        return nil
    end
})

imageurlregex = /\b(https?:\/\/\S+\.(jpg|gif|png))\b/i
lasturl = nil
reactbot.addMessageReaction(imageurlregex, lambda { |event|
    lasturl = event.content[imageurlregex, 1]
    puts "New url: " + lasturl
}, 50)

reactbot.addMessageReaction(//, lambda { |event|
    attachments = event.message.attachments
    return nil unless attachments.length == 1
    if imageurlregex.match(attachments[0].url)
        lasturl = attachments[0].url
        puts "New url: " + lasturl
    end
}, 1) # Last priority because everything matches

reactbotCommandRegex = /^!reactbot\s+(.*)/
reactbotAddImageRegex = /^add (.*) (.*)/
reactbotRmImageRegex = /^rm (.*)/
reactbotAddLastImageRegex = /^addlast (.*)/
reactbotAddModRegex = /^addmod (.*)/
reactbotRmModRegex = /^rmmod (.*)/
reactbot.addMessageReaction(reactbotCommandRegex, lambda { |event|
    command = event.content[reactbotCommandRegex, 1]
    puts command
    case command
    when "list"
        return Dir.chdir("images") do
            return Dir.glob(File.join("*")).join("\t")
        end
    when "listmods"
        return authorizedUsers.map{ |user| user["name"] }.join(", ")
    when /^add\b/
        return "Bad format" unless reactbotAddImageRegex.match(command)
        url = command[reactbotAddImageRegex, 1]
        name = command[reactbotAddImageRegex, 2].downcase
        authorid = event.author.id
        path = File.join("images", name)
        puts authorid.to_s + " trying to add " + url + " as " + name
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        return "Invalid name" unless imagepathregex.match(name)
        return "Destination file already exists" if File.exists? path
        puts "Adding"
        File.open(path, "wb") do | local_file |
            open(url, "rb") do | remote_file |
                local_file.write(remote_file.read)
            end
        end
        return "Image successfully added"
    when /^rm\b/
        return "Bad format" unless reactbotRmImageRegex.match(command)
        name = command[reactbotRmImageRegex, 1].downcase
        path = File.join("images", name)
        authorid = event.author.id
        puts authorid.to_s + " trying to remove " + name
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        return "File does not exist" unless File.exists? path
        File.delete(path)
        return "File successfully deleted"
    when /^addlast\b/
        return "Bad format" unless reactbotAddLastImageRegex.match(command)
        return "No last url" unless lasturl != nil
        name = command[reactbotAddLastImageRegex, 1].downcase
        authorid = event.author.id
        path = File.join("images", name)
        puts authorid.to_s + " trying to add " + lasturl + " as " + name
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        return "Invalid name" unless imagepathregex.match(name)
        return "Destination file already exists" if File.exists? path
        puts "Adding"
        File.open(path, "wb") do | local_file |
            open(lasturl, "rb") do | remote_file |
                local_file.write(remote_file.read)
            end
        end
        return "Image successfully added"
    when /^addmod\b/
        return "Bad format" unless reactbotAddModRegex.match(command)
        name = command[reactbotAddModRegex, 1]
        authorid = event.author.id
        puts authorid.to_s + " trying to add " + name + " as a mod"
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        addedUser = event.channel.users.find{ |u| u.username == name }
        authorizedUsers.push({id: addedUser.id, name: name})
        File.write("authorized_users.json", JSON.generate(authorizedUsers))
        return "Successfully added " + name
    when /^rmmod\b/
        return "Bad format" unless reactbotRmModRegex.match(command)
        name = command[reactbotRmModRegex, 1]
        authorid = event.author.id
        puts authorid.to_s + " trying to remove " + name + " as a mod"
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        authorizedUsers.delete_if{ |u| u["name"] == name }
        File.write("authorized_users.json", JSON.generate(authorizedUsers))
        return "Successfully removed " + name
    when "help"
        return "`list` - list images\n" +
               "`listmods` - list authorized users\n" +
               "`add [url] [name]` - add image from `url` with name `name` (restricted)\n" +
               "`rm [name]` - remove image with name `name` (restricted)\n" +
               "`addlast [name]` - add last image with name `name` (restricted)\n" +
               "`addmod [name]` - add mod with name `name` (restricted)\n" +
               "`rmmod [name]` - remove mod with name `name` (restricted)\n" +
               "`help` - you are a dumbass\n" +
               "`wfsdqpoùifxc` - not implemented yet"
    else
        return "Command `" + command + "` unknown."
    end
}, 200)

reactbot.run
