#!/usr/bin/ruby


class DiceRoller
    def initialize
        @diceRollCommandRegex = /^!roll (\d+(?:d\d+))$/i
        @dieRollRegex = /^(\d+)d(\d+)$/i
    end

    def reactTo(event)
        return if !@diceRollCommandRegex.match event.content
        dice = event.content[@diceRollCommandRegex, 1] # Only supports one die for now
        if /^\d+$/.match dice
            dieType = dice.to_i
            return rand(1..dieType).to_s
        end
        rolls = parseAndRollDie(dice)
        return rolls[0].to_s if rolls.size == 1
        if rolls.size == 0 || rolls[0].nil?
            return "Vraiment ?"
        end
        sum = 0
        returnedString = ""
        rolls.each_with_index do |roll, index|
            returnedString = "#{returnedString}#{roll}"
            returnedString = "#{returnedString}, " if index != rolls.size - 1
            sum += roll
        end
        returnedString = "#{returnedString} = #{sum}"
        return returnedString
    end

    def parseAndRollDie(dieString)
        nbRolls=dieString[@dieRollRegex, 1].to_i
        dieType=dieString[@dieRollRegex, 2].to_i
        return Array.new(nbRolls) { rand(1..dieType) }
    end
end
