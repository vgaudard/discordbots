#!/usr/bin/ruby

require './bot'

STDOUT.sync = true

token = File.read("token").strip
applicationId = File.read("application_id").to_i
secret = File.read("secret").strip
bot = Bot.new(token, applicationId)

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

bot.addPlugin Ping.new
bot.addPlugin RateLimiter.new
bot.addPlugin TaGueule.new
bot.addPlugin Diplodocus.new
bot.addPlugin Thanks.new
bot.addPlugin WritingClock.new
bot.addPlugin ImageReactions.new
bot.addPlugin DiceRoller.new
bot.addPlugin Superuser.new secret
bot.addPlugin Puppet.new

bot.run
