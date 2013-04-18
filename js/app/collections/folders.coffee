app = window.app

Folders = Backbone.Collection.extend
  model: app.Model.Folder
  type: 'folder'

  initialize: ->
    @on 'sync', (model, resp) ->
      if resp? and resp.length?
        app.Iterator.folder.set _.max(resp, (folder) -> folder.id).id

    @fetch()

app.Collection.Folders = new Folders