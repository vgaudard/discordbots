#!/usr/bin/ruby

# This can very reasonably be used for things other than images
class ImageReactions
    def initialize()
        imagesFilePath = File.join(File.dirname(__FILE__), "images.json")
        @imagesLinks = JSON.parse(File.read(imagesFilePath))
    end

    def reactTo(event)
        downcaseContent = event.content.downcase
        if /^[a-z]{2,32}\.[a-z]{2,4}$/.match downcaseContent
            return @imagesLinks[downcaseContent] if @imagesLinks.has_key? downcaseContent
        end
        return ""
    end
end
