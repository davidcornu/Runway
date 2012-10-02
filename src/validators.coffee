exports.presenceOf = (attribute) ->
  return (model, next) ->
    unless model[attribute]
      model.addError(attribute, "#{attribute} cannot be blank")
    next(model)

exports.formatOf = (attribute, format) ->
  return (model, next) ->
    unless format.test(model[attribute])
      model.addError(attribute, "#{attribute} is invalid")
    next(model)