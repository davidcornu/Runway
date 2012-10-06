_      = require('lodash')

exports.generate = (klassName, schema) ->

  builder = new Function 'schema', """
    return function #{klassName}(values){
      if(!values) var values = {};
      this.schema = schema;
      this.generateAttributes();
      this.set(values);
    }
  """

  klass = builder(schema)

  klass::generateAttributes = ->
    @attributes = {}
    for attribute, Type of @schema.mapping
      @[attribute] = new Type

  klass::set = (attribute, value) ->
    if _.isObject(attribute)
      for key, value of attribute
        if key in _.keys(@attributes)
          @attributes[attribute].set(value)
        else
          throw new Error("Attribute #{key} is not defined")
    else
      if attribute in _.keys(@attributes)
        @attributes[attribute].set(value)
      else
        throw new Error("Attribute #{attribute} is not defined")

  klass::get = (attribute) ->
    if attribute in _.keys(@attributes)
      @attributes[attribute].value
    else
      throw new Error("Attribute #{attribute} is not defined")

  klass::toJSON = ->
    result = {}
    for name, attribute in @attributes
      result[name] = attribute.value
    return result

  return klass