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
  robot.router.get '/hubot/coffeebottrigger', (req, res) ->
    if robot.brain.get('coffeeDoneCallback') == null
      # We're not currently brewing!
      robot.messageRoom "bots-bots-bots", "We're starting to brew!"
    else
      # We're already brewing! Turn off the last callback so we can make a new
      # one
      clearTimeout(robot.brain.get('coffeeDoneCallback'))
      robot.brain.set 'coffeeDoneCallback', null

    # After 10 seconds, trigger "Coffee is ready!" with a callback
    coffeeDoneFunc = ->
      robot.messageRoom "bots-bots-bots", "Coffee ready!"
      robot.brain.set 'coffeeDoneCallback', null
    robot.brain.set 'coffeeDoneCallback', setTimeout(coffeeDoneFunc, 10 * 1000)

    res.send 'OK'
