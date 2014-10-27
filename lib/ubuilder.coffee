_ = require 'lodash'

class Ubuilder

  constructor: (url, ext) ->
    @url = ''
    @ext = '.json'
    @paths = []
    @queryParams = {}

  add: (path) ->
    path = {path: path} if typeof(path) == 'string'

    @paths.push path

    return this unless path.rules?

    for rule in path.rules
      if rule.need? and not @hasPath(rule.need)
        throw new Error("You should define the needs path before")

    this

  hasPath: (needPath) ->
    return false if @paths.lenght == 0

    for path in @paths
      if path.path? and path.path == needPath
        return true

    false

  clean: ->
    @paths = []
    @queryParams = {}

    this

  build: ->
    url = ''

    return @url if @paths.length == 0

    for path in @paths
      url += '/' + path.path

      if path.id
        url += '/' + path.id

    url = @url + url + @ext + @queryString()
    @clean()

    url

  addQueryParams: (queryParams) ->
    @queryParams = _.merge @queryParams, queryParams

    this

  queryString: ->
    queryString = []

    _.each @queryParams, (value, key) ->
      queryString.push key + "=" + value

    return '' if queryString.length == 0

    '?' + queryString.join('&')

module.exports = new Ubuilder
