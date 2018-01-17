#!/usr/bin/ruby

require './bot'

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

bot = Bot.new(token, application_id)

require './ping/ping'
require './ratelimiter/ratelimiter'
require './tagueule/tagueule'
require './diplodocus/diplodocus'
require './thanks/thanks'
require './writingclock/writingclock'
require './imagereactions/imagereactions'
require './diceroller/diceroller'
require './superuser/superuser'
require './puppet/puppet'
require './mentions/mentions'

bot.addPlugin Ping.new
bot.addPlugin RateLimiter.new
bot.addPlugin TaGueule.new
bot.addPlugin Diplodocus.new
bot.addPlugin Thanks.new thanksPath
bot.addPlugin WritingClock.new
bot.addPlugin ImageReactions.new imagesPath
bot.addPlugin DiceRoller.new
bot.addPlugin Superuser.new secret
bot.addPlugin Puppet.new
bot.addPlugin Mentions.new mentionsPath

bot.run

