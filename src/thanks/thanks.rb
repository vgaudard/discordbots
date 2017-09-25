#!/usr/bin/ruby

class Thanks
    def initialize()
        thanksFilePath = File.join(File.dirname(__FILE__), "thanks.json")
        @thanksAnswers = JSON.parse(File.read(thanksFilePath))
        @thanksRegex =
            /(good|merci|nice|bien|cool|thx|thank|perfect|parfait).*dip/i
    end
    def reactTo(event)
        return @thanksAnswers.sample if @thanksRegex.match event.content
    end
end
