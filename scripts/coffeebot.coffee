# Description:
#   Posts when coffee starts and ends brewing by listening for GET requests.
#
# Author:
#   Topher. chris.brown@farsounder.com
#   Nick. nicholas.steffen@farsounder.com
#
# Notes:
#   This works in our office by listening to a Sparkfun Photon. When the Photon
#   is on, it pounds our server with GET requests. We know coffee is brewing
#   during this time. When it turns off (ie: we stop getting requests), the
#   coffee is done!
#
#   Whenever we get a new message, we set a callback in the future to post
#   "coffee done". On every new message, we delete the existing callback (so
#   there is only one callback active at a time). Finally, we stop getting
#   messages and the latest callback goes off.

module.exports = (robot) ->
  robot.router.get '/hubot/coffeebottrigger', (req, res) ->
    if robot.brain.get('coffeeDoneCallback') == null
      # We're not currently brewing!
      robot.messageRoom "bots-bots-bots", "We're making coff-ay. :todd:"
    else
      # We're already brewing! Turn off the last callback so we can make a new
      # one
      clearTimeout(robot.brain.get('coffeeDoneCallback'))
      robot.brain.set 'coffeeDoneCallback', null

    # After 10 seconds, trigger "Coffee is ready!" with a callback
    coffeeDoneFunc = ->
      robot.messageRoom "bots-bots-bots", "/giphy coffee"
      robot.brain.set 'coffeeDoneCallback', null
    robot.brain.set 'coffeeDoneCallback', setTimeout(coffeeDoneFunc, 10 * 1000)

    res.send 'OK'
