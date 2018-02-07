#!/usr/bin/ruby

require_relative 'bot'

STDOUT.sync = true

def getConfigPath param
    return File.join(ENV['DISCORDBOTS_CONFIG_PATH'], param)
end
def readConfig param
    return File.read(getConfigPath(param)).strip
end

token = readConfig("token")
application_id = readConfig("application_id").to_i
secret = readConfig("secret")
imagesPath = getConfigPath("images.json")
mentionsPath = getConfigPath("mentions.json")
thanksPath = getConfigPath("thanks.json")
timePath = getConfigPath("time.json")

bot = Bot.new(token, application_id)

Dir[File.join(File.dirname(__FILE__), "plugins", "*.rb")].each {|file| require_relative file }

bot.addPlugin Ping.new
bot.addPlugin RateLimiter.new
bot.addPlugin TaGueule.new
bot.addPlugin Diplodocus.new
bot.addPlugin Thanks.new thanksPath
bot.addPlugin WritingClock.new timePath
bot.addPlugin ImageReactions.new imagesPath
bot.addPlugin DiceRoller.new
bot.addPlugin Superuser.new secret
bot.addPlugin Puppet.new
bot.addPlugin Mentions.new mentionsPath

bot.run

