app = window.app

Notes = Backbone.Collection.extend
  model: app.Model.Note
  type: 'note'

  initialize: ->
    @on 'sync', (model, resp) ->
      if resp? and resp.length?
        app.Iterator.note.set _.max(resp, (note) -> note.id).id

    @fetch()

  bulkRemove: (notesToDelete) ->
    storage = chrome.storage.local
    noteIdsToDelete = _.pluck(notesToDelete, 'id')

    for id in noteIdsToDelete
      modelId = "#{@type}-#{id}"
      storage.remove modelId

    note.trigger 'remove' for note in notesToDelete

    storage.get @type, (ids) ->
      ids['note'] = _.filter(ids['note'], (id) -> id not in noteIdsToDelete)
      storage.set ids


app.Collection.Notes = new Notes