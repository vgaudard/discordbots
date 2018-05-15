#!/usr/bin/ruby

## Josie
class Josie
    def reactTo(event)
        case event.content
        when /josie|josiane/i
            return ["**RAPPEL**", "TRES IMPORTANT", "**RAPPEL TRES IMPORTANT**", "Je ne vous le montre pas souvent mais je vous aime, mes petits choupinoux.", "**RAPPEL 3**\nJE PARS EN PAUSE CAFE. LE BUREAU SERA FERME DE 16H06 A  16H12.", "Je ne vous aime pas. Merci de prendre vos dispositions, notamment pour ceux qui auraient l'horrible envie de venir me voir"].sample
        when /\brappel\b/i
            return "**MES CHOUPINOUX D'AMOUR**"
        end
    end
end
