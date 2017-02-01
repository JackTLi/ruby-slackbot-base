require 'slack-ruby-bot'

SlackRubyBot::Client.logger.level = Logger::ERROR
ENV['SLACK_API_TOKEN'] = "<YOUR SLACK TOKEN HERE>"

class Bot < SlackRubyBot::Bot

  match(/^How is the weather in (?<location>\w*)\?$/) do |client, data, match|
    client.say(channel: data.channel, text: "The weather in #{match[:location]} is nice.")
  end

end

Bot.run
