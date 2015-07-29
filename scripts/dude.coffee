# Description:
#   Responds with "The Big Lebowski" quotes from lebowski.me
#
# Dependencies:
#   Internet connection
#
# Commands:
#   dude
#
# Author:
#   Topher. chris.brown@farsounder.com


module.exports = (robot) ->
  robot.hear /dude/i, (res) ->
    robot.http("http://lebowski.me/api/quotes/random")
    .header('Accept', 'application/json')
    .get() (err, _, body) ->
      if err
        res.send "Dude."
        res.send err
        return
      for line in JSON.parse(body).quote.lines
        res.send "#{line.character.name}: #{line.text}."
