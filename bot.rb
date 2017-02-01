require 'slack-ruby-bot'
require './gravatar_helper.rb'

SlackRubyBot::Client.logger.level = Logger::ERROR
ENV['SLACK_API_TOKEN'] = "<YOUR SLACK TOKEN HERE>"

class Bot < SlackRubyBot::Bot
  include GravatarHelper

  help do
    title 'Weather Bot'
    desc 'This bot tells you the weather.'

    command 'clouds' do
      desc 'Tells you how many clouds there\'re above you.'
    end

    command 'What\'s the weather in <city>?' do
      desc 'Tells you the weather in a <city>.'
      long_desc "Accurate 10 Day Weather Forecasts for thousands of places around the World.\n" \
        'We provide detailed Weather Forecasts over a 10 day period updated four times a day.'
    end
  end

  match(/^How is the weather in (?<location>\w*)\?$/i) do |client, data, match|
    client.say(channel: data.channel, text: "The weather in #{match[:location]} is nice.")
  end

  match(/^Hi/) do |client, data, match|
    puts "ok"

    client.web_client.chat_postMessage(
      channel: data.channel,
      text: "Hello to you too",
      attachments: [
        {
          author_icon: GravatarHelper::gravatar_url("jack.li@shopify.com"),
          fallback: "fallback",
          title: "Title",
          text: "This is some text #{GravatarHelper::gravatar_url("jack.li@shopify.com")}",
          color: "#95BE46"
        }
      ]
    )
  end

  match(/^[Gg]ravatar for <mailto:.*\|(?<email>.*)>\??/) do |client, data, match|
    puts "ok"
    puts match[:email]
    client.web_client.chat_postMessage(
      channel: data.channel,
      text: "Here is the gravatar image for \`#{match[:email]}\`",
      attachments: [
        {
          fallback: "fallback",
          image_url: GravatarHelper::gravatar_url(match[:email])
        }
      ]
    )
  end

  match(/^interesting/) do |client, data, match|
    puts data
  end
end

Bot.run
