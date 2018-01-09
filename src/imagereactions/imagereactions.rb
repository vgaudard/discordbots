#!/usr/bin/ruby

# This can very reasonably be used for things other than images
class ImageReactions
    def initialize images
        @imagesLinks = JSON.parse images
    end

    def reactTo(event)
        downcaseContent = event.content.downcase
        if /^[a-z]{2,32}\.[a-z]{2,4}$/.match downcaseContent
            if @imagesLinks.has_key? downcaseContent 
                return @imagesLinks[downcaseContent].sample if @imagesLinks[downcaseContent].respond_to?('sample')
                return @imagesLinks[downcaseContent] if not @imagesLinks[downcaseContent].respond_to?('sample')
            end
        end
    end
end
