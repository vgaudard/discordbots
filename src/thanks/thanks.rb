#!/usr/bin/ruby

class Thanks
    def initialize thanksPath
        @thanksAnswers = JSON.parse(File.read(thanksPath))
        @thanksRegex =
            /(good|merci|nice|bien|cool|thx|thank|perfect|parfait).*dip/i
    end
    def reactTo(event)
        return @thanksAnswers.sample if @thanksRegex.match event.content
    end
end
