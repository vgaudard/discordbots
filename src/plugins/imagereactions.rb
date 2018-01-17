#!/usr/bin/ruby

require 'fssm'

# This can very reasonably be used for things other than images
class ImageReactions
    def initialize imagesPath
        @imagesPath = imagesPath
        reloadImages
        Thread.new (self) {|ir|
            FSSM.monitor(File.dirname(imagesPath)) do
                update do ||
                    ir.reloadImages
                end
            end
        }
    end

    def reloadImages
        puts "Reloading #{@imagesPath}"
        @imagesLinks = JSON.parse(File.read(@imagesPath))
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
