class Runway

  constructor: (attrs = {}) ->
    @_attributes = {}
    for key, value of attrs
      if key in @attributes
        @_attributes[key] = value

    @_validators = []
    @_errors = {}
    @_dirty = false
    @_buildSetters()
    @_buildGetters()
    @initialize()

  initialize: -> # Placeholder

  _buildSetters: ->
    for attribute in @attributes
      @.__defineSetter__ attribute, (val) =>
        if @_attributes[attribute] != val
          @_dirty = true
        return @_attributes[attribute] = val

  _buildGetters: ->
    for attribute in @attributes
      @.__defineGetter__ attribute, =>
        return @_attributes[attribute]

    @.__defineGetter__ 'errors', =>
      return @_errors

  addValidator: (callback) ->
    @_validators.push(callback) if typeof(callback) == 'function'

  addError: (attribute, errorMessage) ->
    @_errors[attribute] ?= []
    @_errors[attribute].push(errorMessage)

  validate: (callback) ->
    @_errors = []
    validationQueue = @_validators

    next = (model) ->
      return callback(model) if validationQueue.length == 0
      validator = validationQueue.shift()
      validator(model, next)

    next(this)

module.exports = Runway