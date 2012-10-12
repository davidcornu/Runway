_ = require('lodash')

class Runway
  constructor: (attrs = []) ->
    @_attributes  = []
    @_defaults    = {}
    @_filters     = {}

    @attribute(attr) for attr in attrs

  attribute: (attribute, dft) ->
    unless attribute && _.isString(attribute)
      throw new Error('Invalid attribute name ' + attribute)

    @_defaults[attribute] = dft if dft || _.isBoolean(dft)
    @_attributes.push(attribute)

    return this

  use: (attribute, func) ->

    unless attribute in @_attributes || attribute == 'all'
      throw new Error('Invalid attribute name' + attribute)

    unless _.isFunction(func)
      throw new Error('Filter is not a function')

    unless func.length >= 1 and func.length <= 2
      throw new Error('Invalid argument count, should be 1 or 2')

    if attribute == 'all'
      @use(attr, func) for attr in @_attributes
      return this

    (@_filters[attribute] ?= []).push(func)

    return this

  run: (attrs = {}, callback) ->
    result   = {}
    errors   = {}

    attributeQueue = @_attributes.slice()

    nextAttribute = =>

      # Check if there are still attributes to check
      unless attribute = attributeQueue.shift()
        errors = null if _.keys(errors).length == 0
        return callback(errors, result)

      # Get the value from attrs
      value = attrs[attribute] || @_defaults[attribute]
      value = null if _.isUndefined(value)

      # Build a validation queue for that attribute
      filterQueue = @_filters[attribute]?.slice() || []

      # Setup the filter loop
      nextFilter = (err, val) ->

        # Deal with values passed from async filters
        (errors[attribute] ?= []).push(err) if err
        value = val if val

        # Check if there are still filters
        unless filter = filterQueue.shift()
          result[attribute] = value
          return nextAttribute()

        # Deal with synchronous filters
        if filter.length == 1
          try
            filtered = filter(value)
            value    = filtered unless _.isUndefined(filtered)
          catch e
            throw e if e.name == 'TypeError'
            (errors[attribute] ?= []).push(e)

          nextFilter()

        # Deal with async filters
        else
          filter(value, nextFilter)

      # Start filter chain
      nextFilter()

    # Start attribute chain
    nextAttribute()

module.exports = Runway