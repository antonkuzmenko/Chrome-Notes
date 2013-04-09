app = window.app

Folders = Backbone.Collection.extend
  model: app.Model.Folder
  name: 'folders'

  initialize: ->
    @on 'all', (event) -> console.log event, 'Folder event'
    @fetch()

  # Retrieve folders from local storage.
  fetch: (options) ->
    options = if options? then _.clone options else {}
    collection = @
    success = options.success

    chrome.storage.local.get 'folders', (folders) ->
      method = if options.reset then 'reset' else 'set'
      collection[method](folders, options)

      success collection, folders, options if success?
      collection.trigger 'sync', collection, folders, options

#    Backbone.Model::fetch.apply @, options

  save: (options) ->


app.Collection.Folders = new Folders