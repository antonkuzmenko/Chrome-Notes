window.app =
  Model: {}
  Collection: {}
  View: {}
  Mixin: {}
  Iterator: {}
  Template:
    Folder: {}
    Note: {}

# Iterator factory.
iterator = do ->
  ->
    i = 0
    next: -> ++i
    get: -> i
    set: (newI) -> i = newI

window.app.Iterator.folder = iterator()
window.app.Iterator.note = iterator()

# Add unique identifier to the model attributes.
# Used in views and sync with the server.
Backbone.Model::toJSON = ->
  _.extend {}, _.clone(@attributes), id: @id ? @cid

Backbone.sync = (method, model, options) ->
  storageName = model.storageName
  data = options.attrs ? model.toJSON()

  switch method
    when 'create', 'update', 'patch' then chrome.storage.local.set storageName: data
    when 'delete' then chrome.storage.local.remove storageName