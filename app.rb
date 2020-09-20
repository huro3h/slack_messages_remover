require 'slack-ruby-client'

DAY = 86_400
WEEK = DAY * 7
PREVIOUS_WEEK = Time.now - WEEK

APP_TOKEN = ENV['APP_TOKEN']
CHANNEL_ID = ENV['CHANNEL_ID']

def lambda_handler(event:, context:)
  Slack.configure do |config|
    config.token = APP_TOKEN
  end

  client = Slack::Web::Client.new
  messages = client.conversations_history(channel: CHANNEL_ID, count: 20)['messages']
  target_messages = outside_messages(messages).reverse

  return if messages.empty?

  target_messages.each do |target_message|
    client.chat_delete(channel: CHANNEL_ID, ts: target_message.ts)
    sleep(Random.rand(3))
  end
end

# return [Array] メッセージの配列から1週間以上前のメッセージを返す(削除対象)
def outside_messages(messages)
  messages.select{ |message| message.ts < PREVIOUS_WEEK.to_s }
end
