#!/usr/bin/ruby

# This can very reasonably be used for things other than images
class ImageReactions
    def initialize()
        imagesFilePath = File.join(File.dirname(__FILE__), "images.json")
        @imagesLinks = JSON.parse(File.read(imagesFilePath))
    end

    def reactTo(event)
        if /^[a-z]{2,32}\.[a-z]{2,4}$/.match event.content
            puts "Content looks like a file name"
            return @imagesLinks[event.content] if @imagesLinks.has_key? event.content
        end
        return ""
    end
end
