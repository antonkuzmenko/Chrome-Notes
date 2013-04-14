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

# Separate iterators for folders and notes.
window.app.Iterator.folder = iterator()
window.app.Iterator.note = iterator()

# Add unique identifier to the model attributes.
# Used in views and sync with the server.
Backbone.Model::toJSON = ->
  _.extend {}, _.clone(@attributes), id: @id ? @cid

# Use Chromes local storage as a main data storage.
Backbone.sync = (method, model, options) ->
  modelId = "#{model.type}-#{model.id}"
  id = model.id
  storage = chrome.storage.local

  switch method
    when 'create', 'update', 'patch'
      # Save model.
      data = {}
      data[modelId] = options.attrs ? model.toJSON options
      storage.set data, ->
        errorMsg = chrome.runtime.lastError?.message
        # Notify about occured error.
        if errorMsg?
          options.error errorMsg
        else
          # Notify about success.
          options.success data[modelId]
          # Save model id.
          storage.get model.type, (identifiers) ->
            identifiers[model.type] = [] if not identifiers[model.type]?
            ids = identifiers[model.type]

            if model.id not in ids
              ids.push model.id
              storage.set identifiers

    when 'delete'
      # Remove model.
      storage.remove modelId, ->
        errorMsg = chrome.runtime.lastError?.message

        if errorMsg?
          # Notify about occured error.
          options.error errorMsg
        else
          # Notify about success.
          options.success 'ok';
          # Delete model id.
          storage.get model.type, (identifiers) ->
            ids = identifiers[model.type]
            deletedIndex = ids.indexOf id

            if deletedIndex isnt -1
              ids.splice deletedIndex, 1
              storage.set identifiers

    when 'read'
      # Retrieve models ids
      storage.get model.type, (modelIds) ->
        errorMsg = chrome.runtime.lastError?.message

        if errorMsg?
          # Notify about occured error.
          options.error errorMsg
        else
          # Notify about success.
          if _.isEmpty modelIds then return

          models = []
          modelsLen = modelIds[model.type].length
          for id in modelIds[model.type]
            do (id) ->
              storage.get model.type + '-' + id, (data) ->
                models.push(data[model.type + '-' + id])

                if modelsLen is models.length
                  options.success models

          return


#  Trigger native Backbones request event with params. (model, xhr, options)
  model.trigger 'request', model, {}, options
  null
