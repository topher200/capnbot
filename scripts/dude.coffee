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
  robot.hear /dude/i, (res) ->
    robot.http("http://lebowski.me/api/quotes/random")
    .header('Accept', 'application/json')
    .get() (err, _, body) ->
      if err
        res.send "Dude."
        res.send err
        return
      for line in JSON.parse(body).quote.lines
        name = line.character.name
        if line.character.name == "The Dude"
          name = ":dude:"
        res.send "#{name}: #{line.text}"
