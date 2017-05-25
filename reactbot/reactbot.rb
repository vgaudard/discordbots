#!/usr/bin/ruby

require 'open-uri'
require '../root'

reactbot = Bot.new

authorizedUsers = JSON.parse(File.read("authorized_users.json"))

imagepathregex = /\b([a-z]{4,128}\.(jpg|gif|png))\b/i
reactbot.addMessageReaction(imagepathregex, lambda { |event|
    path = 'images/' + event.content[imagepathregex, 1]
    if File.exists? path
        return Message.new('', path)
    else
        return nil
    end
})

reactbotCommandRegex = /^!reactbot\s+(.*)/
reactbotAddImageRegex = /^add (.*) (.*)/
reactbotRmImageRegex = /^rm (.*)/
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
        name = command[reactbotAddImageRegex, 2]
        path = File.join("images", name)
        authorid = event.author.id
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
        name = command[reactbotRmImageRegex, 1]
        path = File.join("images", name)
        authorid = event.author.id
        puts authorid.to_s + " trying to remove " + name
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        return "File does not exist" unless File.exists? path
        File.delete(path)
        return "File successfully deleted"
    when /^addmod\b/
        name = command[reactbotAddModRegex, 1]
        authorid = event.author.id
        puts authorid.to_s + " trying to add " + name + " as a mod"
        return "Unauthorized user" unless authorizedUsers.any? { |user| user["id"] == authorid }
        addedUser = event.channel.users.find{ |u| u.username == name }
        authorizedUsers.push({id: addedUser.id, name: name})
        File.write("authorized_users.json", JSON.generate(authorizedUsers))
        return "Successfully added " + name
    when /^rmmod\b/
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
               "`addmod [name]` - add mod with name `name` (restricted)\n" +
               "`rmmod [name]` - remove mod with name `name` (restricted)\n" +
               "`help` - you are a dumbass\n" +
               "`wfsdqpoùifxc` - not implemented yet"
    else
        return "Command `" + command + "` unknown."
    end
}, 200)

reactbot.run
