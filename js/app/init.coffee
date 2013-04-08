@app =
  Model: {}
  Collection: {}
  View: {}
  Mixin: {}
  Iterator: {}

# Iterator factory.
iterator = do ->
  ->
    i = 0
    next: -> i++
    get: -> i
    set: (newI) -> i = newI

@app.Iterator.folder = iterator()
@app.Iterator.note = iterator()

# Add unique identifier to the model attributes.
# Used in views and sync with the server.
Backbone.Model::toJSON = ->
  _.extend {}, _.clone @attributes, id: @id ? @cid

@.$ = jQuery