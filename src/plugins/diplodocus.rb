#!/usr/bin/ruby

# Makes the most awesome joke ever
# Note: The fact that this joke works only in French but is documented in
#       English might be particularly stupid. Stupid is good.
class Diplodocus
    def initialize()
        # Probability to send the joke on a simple pattern
        @defaultJokeProbability = 40

        # Regex explanation
        # \b            matches start of word
        # (d|cr)[yi]    matches variations of di and cri
        # (\S{3,})      matches rest of the word
        # \b            matches end of word
        @awesomeJokeRegex = /\b(d|cr)[yi](\S{3,})\b/i

        # Regex explanation : (example: diAAAABB)
        # (\p{L})       matches and captures the first letter after "di",
        #               "cri", ...
        #               Example: A
        # \1*           matches potential repeats of the letter except the
        #               first and the last
        #               Example: AA
        # (\1.*)        matches the last repeat and the rest of the word
        #               Example: ABB
        @duplicateRegex = /^(\p{L})\1*(\1.*)$/
    end

    def reactTo(event)
        return if !@awesomeJokeRegex.match event.content
        case event.content
        when /\bdirect\b/i
            return "GET REKT!" if rand(100) < @defaultJokeProbability
        when /\bdiffé/i
            return # This word is used too often to be funny
        when /\bdispute\b/i
            return "PUTE !"
        when /\bdijkstra\b/i
            return "jsk... jkst... jkj... Roy-Warshall!"
        when /\bdib[il][sz][u]/i
            return "JAMAIS JE NE MANQUERAI DE RESPECT À MON SEIGNEUR ET MAITRE!"
        when @awesomeJokeRegex
            return if rand(100) > @defaultJokeProbability
            method = $1.downcase
            response = $2
            response = response[@duplicateRegex, 2]
            response.upcase! if method == "cr"
            response.capitalize! if method == "d"
            return response
        end
    end
end
