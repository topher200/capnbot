# Description:
#   Responds with "The Big Lebowski" quotes from lebowski.me
#
# Dependencies:
#   Internet connection
#
# Commands:
#   dude - Get a random quote from lebowski.me
#
# Author:
#   Topher. chris.brown@farsounder.com


module.exports = (robot) ->
  robot.router.post '/hubot/coffeebottrigger', (req, res) ->
    robot.messageRoom "bots-bots-bots", "Hello bot world!"
    res.send 'OK'
