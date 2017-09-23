#!/usr/bin/ruby

require './bot'

token = File.read("token").strip
applicationId = File.read("application_id").to_i
bot = Bot.new(token, applicationId)

require './ping/ping'
require './ratelimiter/ratelimiter'
require './tagueule/tagueule'
require './diplodocus/diplodocus'
require './thanks/thanks'
require './writingclock/writingclock'

bot.addPlugin Ping.new
bot.addPlugin RateLimiter.new
bot.addPlugin TaGueule.new
bot.addPlugin Diplodocus.new
bot.addPlugin Thanks.new
bot.addPlugin WritingClock.new

bot.run
