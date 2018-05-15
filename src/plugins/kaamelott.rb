#!/usr/bin/ruby

## Kaamelott
class Kaamelott
    def reactTo(event)
        linkregex = /https:\/\/kaamelott-soundboard.2ec0b4.fr\/#son\/([a-zA-Z0-9_-]+)/i
        if linkregex.match event.content
            id = event.content[linkregex, 1]
            mp3path = File.join(File.dirname(__FILE__), "..", "sounds", id + ".mp3")
            puts mp3path
            mp3 = File.open(mp3path)
            event.send_file (mp3)
            mp3.close
        end
    end
end
