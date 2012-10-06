class ConversionError extends Error
  constructor: ->
    @name = 'ConversionError'
    @message = 'Invalid type'

class AttributeError extends Error
  constructor: (attribute) ->
    @name = 'AttributeError'
    @message = 'Invalid type for attribute ' + attribute

module.exports =
  ConversionError: ConversionError
  AttributeError: AttributeError