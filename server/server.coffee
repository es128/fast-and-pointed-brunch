#
# Module dependencies
#

express = require 'express'
routes  = require './routes'
api     = require './routes/api'
http    = require 'http'
path    = require 'path'

app = module.exports = express()

#
# Configuration
#

assetsPath = path.join(__dirname, '..', '_public')

# all environments
app.set 'views', path.join(__dirname, '..', 'client')
app.set 'view engine', 'jade'
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.static(assetsPath)
app.use app.router

# development only
if app.get('env') is 'development'
  app.use express.errorHandler()

# production only
# if app.get('env') is 'production'
  # TODO

#
# Routes
#

# JSON API
app.get '/api/name', api.name

# serve index for all other routes
app.get '*', (req, res) -> res.sendfile "#{assetsPath}/index.html"


#
# Start Server
#

module.exports.startServer = (port, path, callback) ->
  app.set 'port', port
  http.createServer(app).listen port, ->
    console.log "Express server listening on port #{port}"
