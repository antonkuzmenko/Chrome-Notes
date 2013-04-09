Backbone.Model::fetch = (options) ->
  options = if options? then _.clone options else {}
  model = @
  success = options.success

  chrome.storage.local.get "#{@name}-#{@id}", (data) ->
    if not model.set(model.parse(data, options), options) then return false
    success model, data, options if success?
    model.trigger 'sync', model, data, options

    return

Backbone.Collection::fetch = (options) ->
  options = if options? then _.clone options else {}
  collection = @
  success = options.success

  itemNames = @map (item) -> return item.name + item.id
  chrome.storage.local.get itemNames, (data) ->
    method = if options.reset then 'reset' else 'set'
    collection[method](data, options)

    success collection, data, options if success?
    collection.trigger 'sync', collection, data, options

    return