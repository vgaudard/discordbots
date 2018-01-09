#!/usr/bin/ruby

require './bot'

STDOUT.sync = true

def readConfig param
    return File.read(File.join(ENV['DISCORDBOTS_CONFIG_PATH'], param)).strip
end

token = readConfig("token")
application_id = readConfig("application_id").to_i
secret = readConfig("secret")
images = readConfig("images.json")
mentionsPath = File.join(ENV['DISCORDBOTS_CONFIG_PATH'], "mentions.json")

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
bot.addPlugin Thanks.new
bot.addPlugin WritingClock.new
bot.addPlugin ImageReactions.new images
bot.addPlugin DiceRoller.new
bot.addPlugin Superuser.new secret
bot.addPlugin Puppet.new
bot.addPlugin Mentions.new mentionsPath

bot.run

