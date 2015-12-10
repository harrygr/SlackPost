require 'rest-client'


class SlackPost
    attr_writer :message, :username

    def initialize(webhook_url)
        @webhook_url = webhook_url
    end

    def send
        text = @icon.nil? ?  @message : "#{@icon} #{@message}"

        payload = {
            text: text,
            username: @username,
        }

        RestClient.post @webhook_url, :payload => payload.to_json
    end

    def send_message(message)
        @message = message
        self.send()
    end

    def level(level)

        level = level.strip.downcase

        levels = {
            'info'    => ':information_source:',
            'warning' => ':warning:',
            'danger'  => ':bangbang:',
        }

        if levels.key?(level)
            self.with_icon levels[level]
        end
    end

    def with_icon(icon)
        @icon = icon
    end
end