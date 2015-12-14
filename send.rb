#!/usr/bin/env ruby

require_relative 'slack_post'

require 'dotenv'
Dotenv.load File.absolute_path(File.join(File.expand_path(__FILE__), '..', '.env'))

message = ARGV[0]
level = ARGV[1]

slack = SlackPost.new(ENV['SLACK_WEBHOOK_URL'])
slack.username = ENV['USERNAME']

if !level.nil?
    if level[0] == ':' # it's an emoji
        slack.with_icon level
    else
        slack.level level
    end
end

slack.send_message message