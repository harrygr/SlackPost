# SlackPost

### A simple Ruby utility to post to Slack from a shell

SlackPost allows you to post to Slack from your command line. This is especially useful for integrating it into your various server tasks and jobs where it can alert you to important events on your server (e.g. attack, backups etc)

## Installation

1. You will first need a Slack webhook. Follow the instructions in your [Slack settings][1] to get one.

2. Clone the repo, then install the dependencies:
    ```
    $ git clone https://github.com/harrygr/SlackPost.git
    $ cd SlackPost
    $ bundle install
    ```

3. Copy the `.env.example` to `.env` and set your specific environment variables: Your webhook URL, desired username and icon. 

## Usage

From the command line you should now be able to post to Slack to whichever room you configured when setting up the incoming webhook with the command `ruby send.rb [MESSAGE] [LEVEL|EMOJI]`. E.g.

    $ ruby ~/SlackPost/send.rb "Hello World!" "info"

You can also pass in an icon tag for which to precede the message with:

    $ ruby ~/SlackPost/send.rb "The cat meows" ":cat:"

(Ensure the path to `send.rb` is correct. This assumes you cloned into your home directory and your username is "ubuntu")

You can now use this to how other scripts around your system send Slack messages. E.g. in a fail2ban config you might have something like this:

    actionban = iptables -I fail2ban-REPEAT-<name> 1 -s <ip> -j DROP
                # also put into the static file to re-populate after a restart
                ! grep -Fq <ip> /etc/fail2ban/ip.blocklist.<name> && echo "<ip> # fail2ban/$( date ‘+%%Y-%%m-%%d %%T’ ): auto-add for repeat offender" >> /etc/fail2ban/ip.blocklist.<name>
                ruby /home/ubuntu/SlackPost/send.rb "Banned IP <ip> for repeat offences" "WARNING"

which notifies whenever an ip is banned for repeat attacks.

[1]:https://my.slack.com/services/new/incoming-webhook/