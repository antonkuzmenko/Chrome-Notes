app = window.app

Folders = Backbone.Collection.extend
  model: app.Model.Folder
  type: 'folder'

  initialize: ->
    @fetch()

app.Collection.Folders = new Folders